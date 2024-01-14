with_names<-function(y,nm){
  colnames(y)<-paste0(nm[1],".",colnames(y))
  return(y)
}


get_children<-function(x){
  if(length(xmlChildren(x))>0){
    cbind.data.frame(
      with_names(data.frame(as.list(xmlAttrs(x)), stringsAsFactors = FALSE),nm=names(x)),
      bind_rows(lapply(xmlChildren(x),get_children))
    )
  }else{
    as.list(xmlAttrs(x))
  }
}

write_out<-function(x,ext,file,path){
  ext<-tolower(ext)
  if(path!=""){
    file<-basename(file)
    path<-paste0(normalizePath(path),"\\")
  }
  of<-paste0(path,gsub(file,".xml",ext))
  if(ext%in%c(".csv",".txt")){
    data.table::fwrite(x,of)
  }else{
    if(ext==".rds"){
      saveRDS(x,of)
    }else{
      stop("Wrong output format. Choose between .csv, .txt or .rds")
    }
  }
  
}
