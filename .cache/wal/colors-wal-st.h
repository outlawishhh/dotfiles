const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#000000", /* black   */
  [1] = "#6F6F6F", /* red     */
  [2] = "#8F8F8F", /* green   */
  [3] = "#B0B0B0", /* yellow  */
  [4] = "#D0D0D0", /* blue    */
  [5] = "#E8E8E8", /* magenta */
  [6] = "#F3F3F3", /* cyan    */
  [7] = "#f4f4f4", /* white   */

  /* 8 bright colors */
  [8]  = "#aaaaaa",  /* black   */
  [9]  = "#6F6F6F",  /* red     */
  [10] = "#8F8F8F", /* green   */
  [11] = "#B0B0B0", /* yellow  */
  [12] = "#D0D0D0", /* blue    */
  [13] = "#E8E8E8", /* magenta */
  [14] = "#F3F3F3", /* cyan    */
  [15] = "#f4f4f4", /* white   */

  /* special colors */
  [256] = "#000000", /* background */
  [257] = "#f4f4f4", /* foreground */
  [258] = "#f4f4f4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
