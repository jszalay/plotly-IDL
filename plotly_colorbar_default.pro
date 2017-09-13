function plotly_colorbar_default, title

return, { title : title,$
          titleside : 'top',$
          yanchor:"bottom",$
          xanchor:"left",$
          lenmode:"fraction",$
          thickness : 30,$
          len:1.0,$
          y:0.0,$
          x:1.0}

end