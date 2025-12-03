-- claudecode.nvim 커스텀 설정
-- LazyVim extras의 claudecode 플러그인 옵션을 오버라이드합니다
return {
  {
    "coder/claudecode.nvim",
    opts = {
      diff_opts = {
        auto_close_on_accept = true, -- 수락 시 diff 창 자동 닫기
        vertical_split = true, -- 수직 분할
        open_in_current_tab = true, -- 새 윈도우 생성 안 함 (현재 탭에서 열기)
      },
    },
  },
}
