-- claudecode.nvim 커스텀 설정
-- LazyVim extras의 claudecode 플러그인 옵션을 오버라이드합니다
return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal_cmd = "~/.config/workmux/scripts/claude-with-context.sh",
      diff_opts = {
        auto_close_on_accept = true, -- 수락 시 diff 창 자동 닫기
        vertical_split = true, -- 수직 분할
        open_in_current_tab = false, -- 새 탭 생성 방지
        keep_terminal_focus = true, -- Claude 터미널에 포커스 유지
      },
    },
  },
}
