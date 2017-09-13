;;
;; Writes a plotly variable given a structure
pro plotly_var, lun, s, name, js=js, ex=ex, catflag=catflag

;;
;; Get tag names and determine if concatenating data
tags = strlowcase(tag_names(s))
catst = total(tags eq 'catflag')
ntags = n_elements(tags) - (catst ? 1 : 0)
cat =  catst or keyword_set(catflag)

;;
;; Check for concatenation. Write to file with syntax:
;;   var <name> = {<data from "s">}
if cat then begin
  str = 'var '+name + ' = ['
  for j=0,ntags-1 do begin
    if tags[j] eq 'replace' or tags[j] eq 'catflag' then continue
    printf, lun, 'var '+tags[j]+' = '+$
      (json_serialize(s.(j), /lowercase)).replace('\','')+';'
    str+=tags[j]+(j eq ntags-1 ? '];' : ',')
  endfor
  for j=0,n_elements(ex)-1 do printf, lun, ex[j]
  printf, lun, str
endif else printf, lun, 'var '+name+' = '+$
  (keyword_set(js) ? '' : '[')+(json_serialize(s, /lowercase)).replace('\','')+$
  (keyword_set(js) ? '' : ']')+';'

end