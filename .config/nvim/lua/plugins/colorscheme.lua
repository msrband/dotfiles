return {
  -- seoul256 colorscheme 추가
  {
    "junegunn/seoul256.vim",
    lazy = false, -- colorscheme은 즉시 로드
    priority = 1000, -- 다른 플러그인보다 먼저 로드
    config = function()
      -- 배경 밝기 설정 (dark: 233~239, light: 252~256)
      -- 숫자가 낮을수록 어두움
      vim.g.seoul256_background = 235
    end,
  },

  -- LazyVim에서 seoul256 사용하도록 설정
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "seoul256",
    },
  },
}
