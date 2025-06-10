local M = {}

local default_model = "gemini-2.5-pro"

---@param chat CodeCompanion.Chat
---@param model string
function M.update_model(chat, model)
  if chat.adapter and chat.adapter.schema then
    chat.adapter.opts.model = model
    vim.notify("CodeCompanion model set to: " .. model, vim.log.levels.INFO)
  else
    vim.notify("Could not set model for the current chat adapter.", vim.log.levels.ERROR)
  end
end

---@param chat CodeCompanion.Chat
---@param id string
---@param input string
function M.add_image(chat, id, input)
  local new_message = {
    {
      type = "text",
      text = "the user is sharing this image with you. be ready for a query or task regarding this image",
    },
    {
      type = "image_url",
      image_url = {
        url = input,
      },
    },
  }

  local constants = require("codecompanion.config").config.constants
  chat:add_message({
    role = constants.USER_ROLE,
    content = vim.fn.json_encode(new_message),
  }, { reference = id, visible = false })

  chat.references:add({
    id = id,
    source = "adapter.image_url",
  })
end

---@Param chat CodeCompanion.Chat
function M.slash_paste_image(chat)
  local clipboard = require("img-clip.clipboard")
  local paste = require("img-clip.paste")
  local prefix = paste.get_base64_prefix()
  local base64res = clipboard.get_base64_encoded_image()
  local url = prefix .. base64res
  local hash = vim.fn.sha256(url)
  local id = "<pasted-image>" .. hash:sub(1, 16) .. "</pasted-image>"
  M.add_image(chat, id, url)
end

---@param chat CodeCompanion.Chat
function M.slash_add_image_url(chat)
  local function callback(input)
    if input then
      local id = "<image-url>" .. input .. "</image-url>"
      M.add_image(chat, id, input)
    end
  end
  vim.ui.input({ prompt = "> Enter image url: ", default = "", completion = "dir" }, callback)
end

function M.get_slash_commands()
  return {
    ["image_url"] = {
      callback = M.slash_add_image_url,
      description = "Add image via url",
    },
    ["image_paste"] = {
      callback = M.slash_paste_image,
      description = "Add image from clipboard",
    },
  }
end

function M.get_copilot_adapter()
  local copilot = require("codecompanion.adapters.copilot")
  return require("codecompanion.adapters").extend("copilot", {
    handlers = {
      form_parameters = function(self, params, messages)
        local result = copilot.handlers.form_parameters(self, params, messages)
        return result
      end,
      form_messages = function(self, messages)
        local result = copilot.handlers.form_messages(self, messages)
        vim.tbl_map(function(v)
          local ok, json_res = pcall(function()
            return vim.json.decode(v.content)
          end, "not a json")
          if ok then
            v.content = json_res
            local has_image = vim.tbl_filter(function(content)
              return content.type == "image_url"
            end, json_res)
            if has_image then
              self.headers["Copilot-Vision-Request"] = "true"
            end
          end
          return v
        end, result.messages)
        return result
      end,
    },
    schema = {
      model = {
        default = default_model,
      },
    },
  })
end

return M
