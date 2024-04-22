%let pgm=utl-simple-r-code-to-covert-excel-to-sas-and-sas-to-excel;

  Simple r code to covert excel to sas and sas to excel

    1 r sashelp.class to class.xlsx
    2 r class.xlsx to sas7bdat (requires stattransfer)
    3 r class.xlsx to v5 transport
    4 r class.xlsx to v5 long variable names

github
https://tinyurl.com/3jyjr3u7
https://github.com/rogerjdeangelis/utl-simple-r-code-to-covert-excel-to-sas-and-sas-to-excel

related repos on end

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/


/**************************************************************************************************************************/
/*                                 |                                           |                                          */
/* 1 R SASHELP.CLASS TO CLASS.XLSX |                                           |                                          */
/*                                 |                                           |                                          */
/*                                 |                                           |                                          */
/*         INPUT                   |           PROCESS                         |          OUTPUT                          */
/*                                 |                                           |                                          */
/*  NAME    SEX AGE HEIGHT WEIGHT  | %utl_rbegin;                              | d:/xls/want.xlsx                         */
/*                                 | armcards4;                                |                                          */
/*  Alfred  M    14   69    112.   | library(openxlsx)                         | +-------------------+------+             */
/*  Alice   F    13   56.5   84    | library(haven)                            | |   |   A      | B  |   C  |             */
/*  Barbara F    13   65.3   98    | library(data.table)                       | +---+----------+----+------+             */
/*  Carol   F    14   62.8  102.   | have<-read_sas("d:/sd1/class.sas7bdat")   | |   |          |    |      |             */
/*  Henry   M    14   63.5  102.   | wb <- createWorkbook()                    | | 1 |  NAME    | AGE|  SEX |             */
/*  ...                            | addWorksheet(wb, "want")                  | | 2 |  Alfred  | 14 |   M  |             */
/*                                 | writeData(wb, "want", have)               | | 3 |  Alice   | 13 |   F  |             */
/*  libname sd1 "d:/sd1";          | saveWorkbook(wb, "d:/xls/want.xlsx"       | | 4 |  Barbara | 13 |   F  |             */
/*  data sd1.class;                | overwrite = TRUE)                         | | 5 |  Carol   | 14 |   F  |             */
/*    set sashelp.class(           | ;;;;                                      | | 6 |  Henry   | 14 |   M  |             */
/*    keep=name age sex);          | %utl_rend;                                | |.  |  ...     |... | ...  |             */
/*  run;quit;                      |                                           | +--------------+----+------+             */
/*                                 |                                           | [CLASS}                                  */
/*                                 |                                           |                                          */
/* --------------------------------|-------------------------------------------|------------------------------------------*/
/*                                 |                                           |                                          */
/*  d:/xls/want.xlsx               | %utlfkil(d:/xls/want.xlsx);               | TMP.WANT (sas7bdat)                      */
/*                                 |                                           |                                          */
/*  +-------------------+------+   | %utl_rbegin;                              | ROWNAMES    NAME       SEX    AGE        */
/*  |   |   A      | B  |   C  |   | parmcards4;                               |                                          */
/*  +---+----------+----+------+   |  library(openxlsx)                        |     1       Alfred      M      14        */
/*  |   |          |    |      |   |  library(haven)                           |     2       Alice       F      13        */
/*  | 1 |  NAME    | AGE|  SEX |   |  library(data.table)                      |     3       Barbara     F      13        */
/*  | 2 |  Alfred  | 14 |   M  |   |  have<-read_sas("d:/sd1/class.sas7bdat")  |     4       Carol       F      14        */
/*  | 3 |  Alice   | 13 |   F  |   |  wb <- createWorkbook()                   |     5       Henry       M      14        */
/*  | 4 |  Barbara | 13 |   F  |   |  addWorksheet(wb, "want")                 |     6       James       M      12        */
/*  | 5 |  Carol   | 14 |   F  |   |  writeData(wb, "want", have)              |                                          */
/*  | 6 |  Henry   | 14 |   M  |   |  saveWorkbook(wb, "d:/xls/want.xlsx"      |                                          */
/*  |.  |  ...     |... | ...  |   | ,overwrite = TRUE)                        |                                          */
/*  +--------------+----+------+   | ;;;;                                      |                                          */
/*  [CLASS}                        | %utl_rend;                                |                                          */
/*                                 |                                           |                                          */
/* --------------------------------|-------------------------------------------|------------------------------------------*/
/*                                 |                                           |                                          */
/*  d:/xls/want.xlsx               | %utlfkil(d:/xpt/want.xpt);                | XPT.WANT total obs=19   (V5 Transport)   */
/*                                 |                                           |                                          */
/*  +-------------------+------+   | %utl_rbegin;                              |   NAME       SEX    AGE                  */
/*  |   |   A      | B  |   C  |   | parmcards;                                |                                          */
/*  +---+----------+----+------+   | %utl_rbegin;                              |   Alfred      M      14                  */
/*  |   |          |    |      |   | parmcards4;                               |   Alice       F      13                  */
/*  | 1 |  NAME    | AGE|  SEX |   |  library("openxlsx")                      |   Barbara     F      13                  */
/*  | 2 |  Alfred  | 14 |   M  |   |  library(SASxport)                        |   Carol       F      14                  */
/*  | 3 |  Alice   | 13 |   F  |   |  source("c:/temp/fn_tosas9.R")            |   Henry       M      14                  */
/*  | 4 |  Barbara | 13 |   F  |   |  xlsxFile="d:/xls/want.xlsx"              |   James       M      12                  */
/*  | 5 |  Carol   | 14 |   F  |   |  want <- read.xlsx(xlsxFile = xlsxFile)   |   Jane        F      12                  */
/*  | 6 |  Henry   | 14 |   M  |   |  write.xport(want,file="d:/xpt/want.xpt");|                                          */
/*  |.  |  ...     |... | ...  |   | ;;;;                                      |                                          */
/*  +--------------+----+------+   | %utl_rend;                                |                                          */
/*  [CLASS}                        |                                           |                                          */
/*                                 | libname xpt xport "d:/xpt/want.xpt";      |                                          */
/*                                 | proc print data=xpt.want;                 |                                          */
/*                                 | run;quit;                                 |                                          */
/*                                 |                                           |                                          */
/* --------------------------------|-------------------------------------------|------------------------------------------*/
/*                                 |                                           |                                          */
/* d:/xls/want.xlsx (long name)    |                                           |                                          */
/*                                 | %utlfkil(d:/xpt/want.xpt);                |          STUDENT_                        */
/*+-----------------------+------+ |                                           |   Obs      NAME      SEX    AGE          */
/*|   |   A          | B  |   C  | | %utl_rbegin;                              |                                          */
/*+---+--------------+----+------+ | parmcards;                                |     1    Alfred       M      14          */
/*|   |              |    |      | | %utl_rbegin;                              |     2    Alice        F      13          */
/*| 1 | STUDENT_NAME | AGE|  SEX | | parmcards4;                               |     3    Barbara      F      13          */
/*| 2 |  Alfred      | 14 |   M  | |  library("openxlsx")                      |     4    Carol        F      14          */
/*| 3 |  Alice       | 13 |   F  | |  library(SASxport)                        |     5    Henry        M      14          */
/*| 4 |  Barbar      | 13 |   F  | |  source("c:/temp/fn_tosas9.R")            |     6    James        M      12          */
/*| 5 |  Carol       | 14 |   F  | |  xlsxFile="d:/xls/want.xlsx"              |     7    Jane         F      12          */
/*| 6 |  Henry       | 14 |   M  | |  want <- read.xlsx(xlsxFile = xlsxFile)   |     ...                                  */
/*|.  |  ...         |... | ...  | |  for (i in seq_along(want)) {             |                                          */
/*+------------------+----+------+ |      label(want[,i])<- colnames(want)[i]; |    Creates a V5 transpot with long       */
/*[CLASS}                          |      }                                    |    variable names in the label space     */
/*                                 |  write.xport(want,file="d:/xpt/want.xpt");|    area of the V5 transport              */
/*                                 |  ;;;;                                     |                                          */
/*                                 |  %utl_rend;                               |                                          */
/*                                 |                                           |                                          */
/*                                 |  libname xpt xport "d:/xpt/want.xpt";     |                                          */
/*                                 |  proc contents data=xpt._all_;            |                                          */
/*                                 |  run;quit;                                |                                          */
/*                                 |                                           |                                          */
/*                                 |  data want_r_long_names;                  |                                          */
/*                                 |    %utl_rens(xpt.want) ;                  |                                          */
/*                                 |    set want;                              |                                          */
/*                                 |  run;quit;                                |                                          */
/*                                 |  libname xpt clear;                       |                                          */
/*                                 |                                           |                                          */
/*                                 |  proc print data=want_r_long_names;       |                                          */
/*                                 |  run;quit;                                |                                          */
/*                                 |                                           |                                          */
/**********************************|*******************************************|*******************************************/

/*                   _                            _
/ |  ___  __ _ ___  | |_ ___     _____  _____ ___| |
| | / __|/ _` / __| | __/ _ \   / _ \ \/ / __/ _ \ |
| | \__ \ (_| \__ \ | || (_) | |  __/>  < (_|  __/ |
|_| |___/\__,_|___/  \__\___/   \___/_/\_\___\___|_|
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname sd1 "d:/sd1";
data sd1.class;
  set sashelp.class(
  keep=name sex age);
run;quit;

SD1.CLASS total obs=19

Obs    NAME       SEX    AGE

  1    Alfred      M      14
  2    Alice       F      13
  3    Barbara     F      13
  4    Carol       F      14
  5    Henry       M      14
  6    James       M      12


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.CLASS total obs=19                                                                                                */
/*                                                                                                                        */
/*  Obs    NAME       SEX    AGE                                                                                          */
/*                                                                                                                        */
/*    1    Alfred      M      14                                                                                          */
/*    2    Alice       F      13                                                                                          */
/*    3    Barbara     F      13                                                                                          */
/*    4    Carol       F      14                                                                                          */
/*    5    Henry       M      14                                                                                          */
/*    6    James       M      12                                                                                          */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utlfkil(d:/xls/want.xlsx);

%utl_rbegin;
parmcards4;
 library(openxlsx)
 library(haven)
 have<-read_sas("d:/sd1/class.sas7bdat")
 wb <- createWorkbook()
 addWorksheet(wb, "want")
 writeData(wb, "want", have)
 saveWorkbook(wb, "d:/xls/want.xlsx"
,overwrite = TRUE)
;;;;
%utl_rend;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  d:/xls/want.xlsx                                                                                                      */
/*                                                                                                                        */
/*  +-------------------+------+                                                                                          */
/*  |   |   A      | B  |   C  |                                                                                          */
/*  +---+----------+----+------+                                                                                          */
/*  |   |          |    |      |                                                                                          */
/*  | 1 |  NAME    | AGE|  SEX |                                                                                          */
/*  | 2 |  Alfred  | 14 |   M  |                                                                                          */
/*  | 3 |  Alice   | 13 |   F  |                                                                                          */
/*  | 4 |  Barbara | 13 |   F  |                                                                                          */
/*  | 5 |  Carol   | 14 |   F  |                                                                                          */
/*  | 6 |  Henry   | 14 |   M  |                                                                                          */
/*  |.  |  ...     |... | ...  |                                                                                          */
/*  +--------------+----+------+                                                                                          */
/*  [CLASS}                                                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                      _   _                      _____ _         _       _
|___ \    _____  _____ ___| | | |_ ___   ___  __ _ __|___  | |__   __| | __ _| |_
  __) |  / _ \ \/ / __/ _ \ | | __/ _ \ / __|/ _` / __| / /| `_ \ / _` |/ _` | __|
 / __/  |  __/>  < (_|  __/ | | || (_) |\__ \ (_| \__ \/ / | |_) | (_| | (_| | |_
|_____|  \___/_/\_\___\___|_|  \__\___/ |___/\__,_|___/_/  |_.__/ \__,_|\__,_|\__|
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  d:/xls/want.xlsx                                                                                                      */
/*                                                                                                                        */
/*  +-------------------+------+                                                                                          */
/*  |   |   A      | B  |   C  |                                                                                          */
/*  +---+----------+----+------+                                                                                          */
/*  |   |          |    |      |                                                                                          */
/*  | 1 |  NAME    | AGE|  SEX |                                                                                          */
/*  | 2 |  Alfred  | 14 |   M  |                                                                                          */
/*  | 3 |  Alice   | 13 |   F  |                                                                                          */
/*  | 4 |  Barbara | 13 |   F  |                                                                                          */
/*  | 5 |  Carol   | 14 |   F  |                                                                                          */
/*  | 6 |  Henry   | 14 |   M  |                                                                                          */
/*  |.  |  ...     |... | ...  |                                                                                          */
/*  +--------------+----+------+                                                                                          */
/*  [CLASS}                                                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_rbegin;
parmcards4;
 library("openxlsx")
 source("c:/temp/fn_tosas9.R")
 xlsxFile="d:/xls/want.xlsx"
 want <- read.xlsx(xlsxFile = xlsxFile)
 fn_tosas9(dataf=want);
;;;;
%utl_rend;

libname tmp "c:/temp";
proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  TMP.WANT total                                                                                                        */
/*                                                                                                                        */
/*  ROWNAMES    NAME       SEX    AGE                                                                                     */
/*                                                                                                                        */
/*      1       Alfred      M      14                                                                                     */
/*      2       Alice       F      13                                                                                     */
/*      3       Barbara     F      13                                                                                     */
/*      4       Carol       F      14                                                                                     */
/*      5       Henry       M      14                                                                                     */
/*      6       James       M      12                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                     _   _                ____   _                                        _
|___ /    _____  _____ ___| | | |_ ___   __   _| ___| | |_ _ __ __ _ _ __  ___ _ __   ___  _ __| |_
  |_ \   / _ \ \/ / __/ _ \ | | __/ _ \  \ \ / /___ \ | __| `__/ _` | `_ \/ __| `_ \ / _ \| `__| __|
 ___) | |  __/>  < (_|  __/ | | || (_) |  \ V / ___) || |_| | | (_| | | | \__ \ |_) | (_) | |  | |_
|____/   \___/_/\_\___\___|_|  \__\___/    \_/ |____/  \__|_|  \__,_|_| |_|___/ .__/ \___/|_|   \__|
 _                   _                                                         |_|
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  d:/xls/want.xlsx                                                                                                      */
/*                                                                                                                        */
/*  +-------------------+------+                                                                                          */
/*  |   |   A      | B  |   C  |                                                                                          */
/*  +---+----------+----+------+                                                                                          */
/*  |   |          |    |      |                                                                                          */
/*  | 1 |  NAME    | AGE|  SEX |                                                                                          */
/*  | 2 |  Alfred  | 14 |   M  |                                                                                          */
/*  | 3 |  Alice   | 13 |   F  |                                                                                          */
/*  | 4 |  Barbar  | 13 |   F  |                                                                                          */
/*  | 5 |  Carol   | 14 |   F  |                                                                                          */
/*  | 6 |  Henry   | 14 |   M  |                                                                                          */
/*  |.  |  ...     |... | ...  |                                                                                          */
/*  +--------------+----+------+                                                                                          */
/*  [CLASS}                                                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

%utlfkil(d:/xpt/want.xpt);

%utl_rbegin;
parmcards;
%utl_rbegin;
parmcards4;
 library("openxlsx")
 library(SASxport)
 source("c:/temp/fn_tosas9.R")
 xlsxFile="d:/xls/want.xlsx"
 want <- read.xlsx(xlsxFile = xlsxFile)
 write.xport(want,file="d:/xpt/want.xpt");
;;;;
%utl_rend;

libname xpt xport "d:/xpt/want.xpt";
proc print data=xpt.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* XPT.WANT total obs=19                                                                                                  */
/*                                                                                                                        */
/*   NAME       SEX    AGE                                                                                                */
/*                                                                                                                        */
/*   Alfred      M      14                                                                                                */
/*   Alice       F      13                                                                                                */
/*   Barbara     F      13                                                                                                */
/*   Carol       F      14                                                                                                */
/*   Henry       M      14                                                                                                */
/*   James       M      12                                                                                                */
/*   Jane        F      12                                                                                                */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                     _                ____               _     _
| || |    ___  __ _ ___  | |_ ___   __   _| ___|  __  ___ __ | |_  | | ___  _ __   __ _   _ __   __ _ _ __ ___   ___  ___
| || |_  / __|/ _` / __| | __/ _ \  \ \ / /___ \  \ \/ / `_ \| __| | |/ _ \| `_ \ / _` | | `_ \ / _` | `_ ` _ \ / _ \/ __|
|__   _| \__ \ (_| \__ \ | || (_) |  \ V / ___) |  >  <| |_) | |_  | | (_) | | | | (_| | | | | | (_| | | | | | |  __/\__ \
   |_|   |___/\__,_|___/  \__\___/    \_/ |____/  /_/\_\ .__/ \__| |_|\___/|_| |_|\__, | |_| |_|\__,_|_| |_| |_|\___||___/
                                                       |_|                        |___/
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

* create an excel sheet with a long variable name 'student_name ;

libname sd1 "d:/sd1";
data sd1.class;
  set sashelp.class(
  keep=name sex age
  rename=name=student_name);
run;quit;

%utlfkil(d:/xls/want.xlsx);

%utl_rbegin;
parmcards4;
 library(openxlsx)
 library(haven)
 have<-read_sas("d:/sd1/class.sas7bdat")
 wb <- createWorkbook()
 addWorksheet(wb, "want")
 writeData(wb, "want", have)
 saveWorkbook(wb, "d:/xls/want.xlsx"
,overwrite = TRUE)
;;;;
%utl_rend;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  d:/xls/want.xlsx (note long variable name 'STUDENT_NAME"                                                              */
/*                                                                                                                        */
/*  +-----------------------+------+                                                                                      */
/*  |   |   A          | B  |   C  |                                                                                      */
/*  +---+--------------+----+------+                                                                                      */
/*  |   |              |    |      |                                                                                      */
/*  | 1 | STUDENT_NAME | AGE|  SEX |                                                                                      */
/*  | 2 |  Alfred      | 14 |   M  |                                                                                      */
/*  | 3 |  Alice       | 13 |   F  |                                                                                      */
/*  | 4 |  Barbar      | 13 |   F  |                                                                                      */
/*  | 5 |  Carol       | 14 |   F  |                                                                                      */
/*  | 6 |  Henry       | 14 |   M  |                                                                                      */
/*  |.  |  ...         |... | ...  |                                                                                      */
/*  +------------------+----+------+                                                                                      */
/*  [CLASS}                                                                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utlfkil(d:/xpt/want.xpt);

%utl_rbegin;
parmcards;
%utl_rbegin;
parmcards4;
 library("openxlsx")
 library(SASxport)
 source("c:/temp/fn_tosas9.R")
 xlsxFile="d:/xls/want.xlsx"
 want <- read.xlsx(xlsxFile = xlsxFile)
 for (i in seq_along(want)) {
           label(want[,i])<- colnames(want)[i];
        }
 write.xport(want,file="d:/xpt/want.xpt");
;;;;
%utl_rend;

libname xpt xport "d:/xpt/want.xpt";
proc contents data=xpt._all_;
run;quit;

data want_r_long_names;
  %utl_rens(xpt.want) ;
  set want;
run;quit;
libname xpt clear;

proc print data=want_r_long_names;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/* WE CREATED A SAS DATASET WITH  LONG VARIABLE NAME 'STUDENT_NAME'. MORE THAN 8 CHARACTERS.                              */
/*                                                                                                                        */
/*        STUDENT_                                                                                                        */
/* Obs      NAME      SEX    AGE                                                                                          */
/*                                                                                                                        */
/*   1    Alfred       M      14                                                                                          */
/*   2    Alice        F      13                                                                                          */
/*   3    Barbara      F      13                                                                                          */
/*   4    Carol        F      14                                                                                          */
/*   5    Henry        M      14                                                                                          */
/*   6    James        M      12                                                                                          */
/*   7    Jane         F      12                                                                                          */
/*   ...                                                                                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __ ___ _ __   ___  ___
| `__/ _ \ `_ \ / _ \/ __|
| | |  __/ |_) | (_) \__ \
|_|  \___| .__/ \___/|___/
         |_|
*/


https://github.com/rogerjdeangelis/utl_excel_import_data_from_a_xlsx_file_where_first_2_rows_are_header
https://github.com/rogerjdeangelis/utl_excel_import_entire_directory
https://github.com/rogerjdeangelis/utl_excel_import_long_colnames
https://github.com/rogerjdeangelis/utl_excel_import_only_female_students
https://github.com/rogerjdeangelis/utl_excel_import_sas_functions_fail_on_cells_with_mutiple_line_breaks
https://github.com/rogerjdeangelis/utl_excel_import_sub_rectangle
https://github.com/rogerjdeangelis/utl_excel_import_two_excel_ranges_within_one_sheet
https://github.com/rogerjdeangelis/utl_excel_import_xlsm_to_sas_dataset
https://github.com/rogerjdeangelis/utl_excel_importing_unicode_and_other_special_characters_without_changing_sas_encoding
https://github.com/rogerjdeangelis/utl_excel_sas_wps_r_import_xlsx_without_sas_access_to_pc_files
https://github.com/rogerjdeangelis/utl_fix_excel_column_names_before_import
https://github.com/rogerjdeangelis/utl_hex_dump_of_fixed_record_formated_file_or_importing_a_text_file_with_no_headers
https://github.com/rogerjdeangelis/utl_import_all_excel_workbooks_created_in_the_previous_seven_days
https://github.com/rogerjdeangelis/utl_import_complicated_multi_header_and_trailer_text_files
https://github.com/rogerjdeangelis/utl_import_data_from_excel_sheet_with_headers_and_footers_without_specifying_range_option
https://github.com/rogerjdeangelis/utl_import_excel_column_names_that_contain_a_dollar_sign_and_rename_without
https://github.com/rogerjdeangelis/utl_import_excel_unicode
https://github.com/rogerjdeangelis/utl_import_file_with_multiple_record_types
https://github.com/rogerjdeangelis/utl_import_json_r_2_lines_of_code
https://github.com/rogerjdeangelis/utl_import_sas_dataset_meta_into_r_data_using_the_free_wps_express
https://github.com/rogerjdeangelis/utl_importing_and_exporting_sas7bdats__without_sas
https://github.com/rogerjdeangelis/utl_importing_json_file_data_into_sas_as_a_dataset
https://github.com/rogerjdeangelis/utl_importing_long_strings_from_ms_access
https://github.com/rogerjdeangelis/utl_importing_multiple_pwd_protected_xlm_workbook_and_sheets
https://github.com/rogerjdeangelis/utl_importing_r_created_v8_transport_files_into_sas_wps
https://github.com/rogerjdeangelis/utl_importing_three_excel_tables_that_are_in_one_sheet
https://github.com/rogerjdeangelis/utl_joining_and_updating_excel_sheets_without_importing_data
https://github.com/rogerjdeangelis/utl_maintaining_all_significant_digits_when_importing_excel_sheet
https://github.com/rogerjdeangelis/utl_maintaining_numeric_significance_when_exporting_and_importing_excel_workbooks
https://github.com/rogerjdeangelis/utl_proc_import_columns_as_character_from_excel_linux_or_windows
https://github.com/rogerjdeangelis/utl_remove_unnecessary_rows_when_I_import_an_xlsx_file
https://github.com/rogerjdeangelis/utl_renaming_duplicate_excel_columns_to_avoid_name_collisions_when_importing


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
