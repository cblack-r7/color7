/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#2e363e", /* black   */
  [1] = "#ed6e3e", /* red     */
  [2] = "#00b07e", /* green   */
  [3] = "#f9a029", /* yellow  */
  [4] = "#006ec5", /* blue    */
  [5] = "#9853de", /* magenta */
  [6] = "#5797b7", /* cyan    */
  [7] = "#4e4e4e", /* white   */

  /* 8 bright colors */
  [8]  = "#373b41", /* black   */
  [9]  = "#f58f30", /* red     */
  [10] = "#00b07e", /* green   */
  [11] = "#fad15a", /* yellow  */
  [12] = "#0094d1", /* blue    */
  [13] = "#ac6ced", /* magenta */
  [14] = "#6c78ed", /* cyan    */
  [15] = "#7a858d", /* white   */

  /* special colors */
  [256] = "#e5e5e5", /* background */
  [257] = "#414d58", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;

