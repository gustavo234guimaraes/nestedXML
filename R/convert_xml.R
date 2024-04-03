convert_xml<-function(file,ext='.csv',out_dir=""){
  
  arqXML<-xml2::read_xml(file)
  node<-xml_name(xml_child(arqXML))
  
  nodes<-xml_find_all(arqXML, paste0("//", node))
  lapply(nodes, function(x){
    parent <- data.frame(as.list(xml_attrs(x)), stringsAsFactors = FALSE)
    kids <- bind_rows(lapply(xml_children(x), get_children))
    cbind.data.frame(parent, kids, stringsAsFactors = FALSE)
  }) %>% unlist(recursive = F) %>%
    suppressMessages() %>% 
    write_out(ext=ext,file=file,path=out_dir)
  
  return(TRUE)
  
}