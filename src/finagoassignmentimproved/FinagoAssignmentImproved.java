package finagoassignmentimproved;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class FinagoAssignmentImproved {

    public static void main(String[] args) {

        String templateName = "CSVTemplate.xsl";
        String inputXML = "exampleInvoice.xml";
        String outputFileName = "Finvoice.csv";
        
        try {
            //Loading the template for the csv as well as the input XML the application
            File stylesheet = new File(templateName);
            File input = new File(inputXML);
            
            //Creating a document object and parsing the input from the XML file to the document object
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(input);
            
            //Applying the xsl template to the xml to create a CSV file in the specified format
            StreamSource stylesource = new StreamSource(stylesheet);
            Transformer transformer = TransformerFactory.newInstance()
                    .newTransformer(stylesource);
            Source source = new DOMSource(document);
            Result outputTarget = new StreamResult(new File(outputFileName));
            transformer.transform(source, outputTarget);
            System.out.println("Program ran succesfully, you can find your new csv file at the root directory of this project under the name " +outputFileName);
        } catch (TransformerException | SAXException | IOException | ParserConfigurationException ex) {
            System.out.println("One of the filenames is not present in the directory, please check the filename and try again");
        }
    }
    
}
