;;
;; Writes a plotly footer
pro plotly_footer, lun

;;
;; Write footer
q = string(39B)
printf, lun, ''
printf, lun, 'Plotly.newPlot('+q+'myDiv'+q+', data, layout);'
printf, lun, ''
printf, lun, '</script>'
printf, lun, '</body>'

end