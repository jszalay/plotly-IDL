;;
;; Writes a plotly header
pro plotly_header, lun, offline=offline, sourcefile=sourcefile

;;
;; Determine number of source files to load
ns = n_elements(sourcefile)

;;
;; Write header
printf, lun, '<!DOCTYPE html>'
printf, lun, '<head>'
printf, lun, ''
printf, lun, '<!-- Plotly.js Library -->'
if keyword_set(offline) then plotly_write_source, lun else $
printf, lun, '<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>'
printf, lun, ''
if ns gt 0 then begin
  printf, lun, '<!-- Read in orbit data -->'
  for i=0,ns-1 do $    
    printf, lun, '<script type="text/javascript" src="'+sourcefile[i]+'"></script>'
endif
printf, lun, '
printf, lun, '</head>
printf, lun, '<body>
printf, lun, '
printf, lun, '<!-- Plotly chart will be drawn inside this DIV -->
printf, lun, '<div id="myDiv" style="width:100%;height:100%"></div>
printf, lun, '<script>
printf, lun, ''

end
