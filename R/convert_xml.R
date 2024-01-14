convert_xml<-function(file,ext='.csv',out_dir=""){
  
  arqXML<-xmlParse(file)
  node<-names(xmlRoot(arqXML))
  
  
  bind_rows(xpathApply(arqXML, paste0("//",node), function(x) {
    parent <- data.frame(as.list(xmlAttrs(x)), stringsAsFactors = FALSE)
    kids <- bind_rows(lapply(xmlChildren(x), get_children))
    cbind.data.frame(parent, kids, stringsAsFactors = FALSE)
  })) %>% suppressMessages() %>% 
    write_out(ext=ext,file=file,path=out_dir)
  
  return(TRUE)
  
}