static const char norm_fg[] = "#f4f4f4";
static const char norm_bg[] = "#000000";
static const char norm_border[] = "#aaaaaa";

static const char sel_fg[] = "#f4f4f4";
static const char sel_bg[] = "#8F8F8F";
static const char sel_border[] = "#f4f4f4";

static const char urg_fg[] = "#f4f4f4";
static const char urg_bg[] = "#6F6F6F";
static const char urg_border[] = "#6F6F6F";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
