from datetime import datetime

from kitty.fast_data_types import Screen, add_timer, get_boss, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_fade,
)
from kitty.utils import color_as_int

_timer_id = None


def _redraw_tab_bar(_timer):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global _timer_id
    if _timer_id is None:
        # HH:MM clock, so a coarse refresh is enough
        _timer_id = add_timer(_redraw_tab_bar, 2.0, True)

    end = draw_tab_with_fade(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        clock = datetime.now().strftime(" %H:%M ")
        if screen.columns - screen.cursor.x > len(clock):
            screen.cursor.x = screen.columns - len(clock)
            screen.cursor.fg = as_rgb(color_as_int(get_options().foreground))
            screen.cursor.bg = 0
            screen.draw(clock)
    return end
