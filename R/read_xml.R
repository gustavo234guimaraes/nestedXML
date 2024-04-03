read_xml<-function(file,node=NULL){
  
  
  
  arqXML<-xml2::read_xml(file)
  if(is.null(node)){
    node<-xml_name(xml_child(arqXML))
  }
  
  
  nodes<-xml_find_all(arqXML, paste0("//", node))
  lapply(nodes, function(x){
    parent <- data.frame(as.list(xml_attrs(x)), stringsAsFactors = FALSE)
    kids <- bind_rows(lapply(xml_children(x), get_children))
    cbind.data.frame(parent, kids, stringsAsFactors = FALSE)
  }) %>% unlist(recursive = F) %>%
    suppressMessages() %>% 
    return()
  
}
