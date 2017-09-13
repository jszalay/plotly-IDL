;+
; NAME:
;     PLOTLY_PLOT
;
; PURPOSE:
;     Write a plotly html file
;
; EXPLANATION:
;      Further information on format for plotly formatting is available at
;      https://plot.ly/javascript/reference/
;
; CALLING SEQUENCE:
;     PLOTLY_PLOT, data, layout, file=file,$
;                  offline=offline, noreplace=noreplace,$
;                  ex1=ex1, ex2=ex2
;
; INPUTS:
;      data     = Plotly data structure or strucutre of plotly structures.
;      
;      layout   = Plotly layout structure
;
; OPTIONAL INPUT KEYWORDS:
;       file       The output file name. By default, the filename is 
;                  ~/Desktop/plotly.html 
;       
;       offline    If specified, the plotly javascript library will be written
;                  into the html file. For this to work, the file
;                  'plotly.min.js' must be within the IDL path. The latest 
;                  version can be found here: 
;                    https://cdn.plot.ly/plotly-latest.min.js
;                    
;       catflag    A flag which tells the code that "data" is a structure of
;                  plotly structures.
;                
;       noreplace  If specified, will force the procedure not to run the 
;                  perl scripts which replace certain quantities in the file.
;                  
;       ex1        An optional string that can modify information within data
;       
;       ex2        An optional string that can modify informatino within layout
;       
;       ct         Specifies the IDL colortable to be used. If none given, will
;                  revert to the JADE nominal color table
;
; EXAMPLES:
;       (1) Simple line:
;             plotly_plot, {x:[1,2,3],y:[1,2,3]}
;             
;       (2) Multiple lines
;             plotly_plot, { data1 : { x : dindgen(10),$
;                                      y : dindgen(10),$
;                                      name : 'y=x'},$
;                            data2 : { x : dindgen(10),$
;                                      y : dindgen(10)^2,$
;                                      name : 'y=x<sup>2</sup>'}},$
;                           /cat
;                           
;       (3) Heatmap with simple axis labels and showing 2 decimal places
;           in the (x,y) hover labels
;             plotly_plot, { x    : dindgen(10),$
;                            y    : dindgen(10),$
;                            z    : randomu(seed,10,10),$
;                            type : 'heatmap',$
;                            colorbar : plotly_colorbar_default('z'),$
;                            colorscale : 'Jet'},$
;                          { xaxis : {title:'x',$
;                                     hoverformat:'.2f'},$
;                            yaxis : {title:'y',$
;                                     hoverformat:'.2f'}}
; 
; NOTES:
;
; PROCEDURES USED:
;   The following procedures are called by plotly_plot:
;       plotly_header       -- Writes the header
;       plotly_var          -- The main procedure which writes information in 
;                              JSON format
;       plotly_write_source -- Writes the plotly javascript library to the
;                              output file
;       plotly_footer       -- Writes the footer
;       plotly_replace      -- Calls a perl script to replace certain quantites                             
;       plotly_colorbar     -- Writes a specified colorbar wherever 'replace_cb'
;                              is specified in the file
;
; AUTHOR:
;   Jamey Szalay
;
; DATE:
;   01-Feb-2016
;
; MODIfICATION HISTORY:
; 
;   08-Mar-2016  jrs  Updated header to describe this procedure.
;       
;-
pro plotly_plot, data, layout,  $
  file=file, offline=offline,$
  catflag=catflag,$
  replace=replace,$
  noreplace=noreplace,$
  ex1=ex1, ex2=ex2,$
  ct=ct,$
  noquote=noquote,$
  silent=silent

;;
;; Set filename
file = n_elements(file) eq 1 ? file : '~/Desktop/plotly.html'

;;
;; Open file and write header
openw, lun, file, /get_lun
plotly_header, lun, offline=offline

;;
;; Write data and layout
plotly_var, lun, data, 'data', ex=ex1, catflag=catflag
plotly_layout, lun, layout=layout

;;
;; Add extra strings if requested
for i=0,n_elements(ex2)-1 do printf, lun, ex2[i]

;;
;; Write footer and close
plotly_footer, lun
close, lun
free_lun, lun
if ~keyword_set(silent) then print, 'Plotly written to '+file

;;
;; Replace various quantities in the html file
tags = strlowcase(tag_names(data))
if total(tags eq 'replace') eq 1 then replace=*data.replace
if ~keyword_set(noreplace) then plotly_replace, file, replace=replace, ct=ct,$
  noquote=noquote
end