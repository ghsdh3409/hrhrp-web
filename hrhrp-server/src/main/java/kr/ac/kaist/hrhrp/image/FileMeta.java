package kr.ac.kaist.hrhrp.image;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
 
//ignore "bytes" when return json format
@JsonIgnoreProperties({"bytes"}) 
public class FileMeta {
 
    private String fileName;
    private String fileSize;
    private String fileType;
 
    private byte[] bytes;
 
    public void setFileName(String aFileName) {
    	fileName = aFileName;
    }
    
    public void setFileSize(String aFileSize) {
    	fileSize = aFileSize;
    }
    
    public void setFileType(String aFileType) {
    	fileType = aFileType;
    }
    
    public void setBytes(byte[] aBytes) {
    	bytes = aBytes;
    }
    
    public String getFileName() {
    	return fileName;
    }
    
    public String getFileSize() {
    	return fileSize;
    }
    
    public String getFileType() {
    	return fileType;
    }
    
    public byte[] getBytes() {
    	return bytes;
    }
    
}