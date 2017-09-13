;;
;; The file 'plotly.min.js' must be in the same directory as this procedure.
;; This can be found at https://cdn.plot.ly/plotly-latest.min.js
pro plotly_write_source, lun

;;
;; Get file name and read contexts
name = 'plotly.min.js'
file = file_dirname((routine_info('plotly_write_source',/source)).path)+$
  path_sep() + name

;;
;; Read contexts
nlines = file_lines(file)
openr, lun2, file, /get_lun
line = ''
printf, lun, '<script>'
WHILE NOT EOF(lun2) DO BEGIN 
  READF, lun2, line 
  printf, lun, line
ENDWHILE
printf, lun, '</script>'

; Close the file and free the file unit
FREE_LUN, lun2

end