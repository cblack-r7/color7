/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#414d58", /* black   */
  [1] = "#e95f26", /* red     */
  [2] = "#00b07e", /* green   */
  [3] = "#f9a029", /* yellow  */
  [4] = "#006ec5", /* blue    */
  [5] = "#9853de", /* magenta */
  [6] = "#5797b7", /* cyan    */
  [7] = "#7f8d9a", /* white   */

  /* 8 bright colors */
  [8]  = "#97a3ab", /* black   */
  [9]  = "#f58f30", /* red     */
  [10] = "#affed3", /* green   */
  [11] = "#fad15a", /* yellow  */
  [12] = "#2596cd", /* blue    */
  [13] = "#ac6ced", /* magenta */
  [14] = "#6c78ed", /* cyan    */
  [15] = "#dde5e8", /* white   */

  /* special colors */
  [256] = "#182028", /* background */
  [257] = "#e9eef0", /* foreground */
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

