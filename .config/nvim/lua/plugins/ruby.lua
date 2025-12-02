-- Ruby/Rubocop 설정: Gemfile 존재 시 bundle exec 사용
-- Mason의 rubocop 버전 충돌 방지

-- Gemfile 존재 여부 확인 헬퍼
local function has_gemfile()
  local gemfile = vim.fn.findfile("Gemfile", ".;")
  return gemfile ~= ""
end

-- rubocop command 결정
local function rubocop_command()
  if has_gemfile() then
    return "bundle"
  else
    return "rubocop"
  end
end

return {
  -- Mason에서 rubocop 자동 설치 방지 (bundle exec 사용)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "rubocop"
      end, opts.ensure_installed)
    end,
  },

  -- conform.nvim (formatter) 설정 오버라이드
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        rubocop = {
          command = rubocop_command,
          args = function()
            if has_gemfile() then
              return {
                "exec",
                "rubocop",
                "-a",
                "-f",
                "quiet",
                "--stderr",
                "--stdin",
                "$FILENAME",
              }
            else
              return {
                "-a",
                "-f",
                "quiet",
                "--stderr",
                "--stdin",
                "$FILENAME",
              }
            end
          end,
        },
      },
    },
  },

  -- nvim-lint 설정 오버라이드
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")

      -- rubocop linter 커스터마이징
      local rubocop = lint.linters.rubocop or {}
      rubocop.cmd = function()
        local gemfile = vim.fn.findfile("Gemfile", ".;")
        return gemfile ~= "" and "bundle" or "rubocop"
      end
      rubocop.args = function()
        local gemfile = vim.fn.findfile("Gemfile", ".;")
        local filename = vim.api.nvim_buf_get_name(0)
        if gemfile ~= "" then
          return {
            "exec",
            "rubocop",
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            filename,
          }
        else
          return {
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            filename,
          }
        end
      end
      lint.linters.rubocop = rubocop

      return opts
    end,
  },
}
