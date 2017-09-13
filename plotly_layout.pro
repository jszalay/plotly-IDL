;;
;; Writes a plotly footer
pro plotly_layout, lun, layout=layout

;;
;; Create layout
layout = n_elements(layout) ne 0 ? layout : { $
;           height: 1000, $
;           width:1100,$
           autosize: 0, $
           title: "",$
           xaxis: {$
             autorange: 1, $
             mirror: "all",$
           showline: 1, $
             title: ""$
           },$
           yaxis: {$ 
             showline: 1, $
             title: "", $
             titlefont: {$
               color: "#082567", $
               family: "helvetica, sans-serif", $
               size: 20$
             }, $
             type: "lin" $
           }$
         }

;;
;; Write layout
plotly_var, lun, layout, 'layout', /js

end