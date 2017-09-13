pro plotly_replace, file, replace=replace, ct=ct, noquote=noquote

q = string(39B)

;;
;; Replace instances of "true"/"false" with non-string versions
spawn, 'perl -pi -e '+q+'s/"true"/true/g'+q+' '+file
spawn, 'perl -pi -e '+q+'s/"false"/false/g'+q+' '+file
spawn, 'perl -pi -e '+q+'s/"replace_true"/true/g'+q+' '+file
spawn, 'perl -pi -e '+q+'s/"replace_false"/false/g'+q+' '+file

;; replace NaN
spawn, 'perl -pi -e '+q+'s/NaN/"NaN"/g'+q+' '+file

;;
;; Replace colorbar
spawn, 'perl -pi -e '+q+'s/"replace_cb"/'+plotly_colorbar(ct=ct)+'/g'+q+' '+file

;;
;; Replace annotations
str = '[{"text":"L","xref":"paper","yref":"paper","arrowsize":0.29999999999999993,"arrowhead":0,"ax":16,"ay":-63,"x":0.9739583333333335,"y":-0.010494652220152112,"showarrow":false,"font":{"color":"rgb(5, 10, 172)"}},{"text":"M","showarrow":false,"x":0.9877604047452655,"y":-0.010494652220152112,"xref":"paper","yref":"paper","font":{"color":"rgb(4, 238, 249)"}},{"text":"H","xref":"paper","yref":"paper","showarrow":false,"x":0.9986979166666667,"y":-0.010494652220152112,"font":{"color":"rgb(255, 65, 0)"}}]'
spawn,  'perl -pi -e '+q+'s/"replace_lmh"/'+str+'/g'+q+' '+file

;;
;; Replace additional quantities
q2 = keyword_set(noquote) ? '' : '"'
if size(replace,/type) eq 7 then for i=0,n_elements(replace)/2-1 do $
  spawn,  'perl -pi -e '+q+'s/'+q2+replace[0,i]+q2+'/'+replace[1,i]+'/g'+q+' '+file
end