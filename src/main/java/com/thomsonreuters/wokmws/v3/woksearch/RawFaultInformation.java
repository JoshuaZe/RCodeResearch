
package com.thomsonreuters.wokmws.v3.woksearch;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 *       The RawFaultInformation is consists of the static message text of the faultstring, message, reason, cause and remedy elements
 *       along with the message data used to instantiate the message parameters. Message parameters are of the form {0}, {1}, etc. 
 *       and conform to the Java 5 java.text.MessageFormat API.  
 *        
 *       This information did not exist in WokSearch version 2. However the Fault did exist.  
 *       
 * 
 * <p>RawFaultInformation complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="RawFaultInformation">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="rawFaultstring" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="rawMessage" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="rawReason" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="rawCause" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="rawRemedy" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="messageData" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RawFaultInformation", propOrder = {
    "rawFaultstring",
    "rawMessage",
    "rawReason",
    "rawCause",
    "rawRemedy",
    "messageData"
})
public class RawFaultInformation {

    protected String rawFaultstring;
    protected String rawMessage;
    protected String rawReason;
    protected String rawCause;
    protected String rawRemedy;
    protected List<String> messageData;

    /**
     * 获取rawFaultstring属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRawFaultstring() {
        return rawFaultstring;
    }

    /**
     * 设置rawFaultstring属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRawFaultstring(String value) {
        this.rawFaultstring = value;
    }

    /**
     * 获取rawMessage属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRawMessage() {
        return rawMessage;
    }

    /**
     * 设置rawMessage属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRawMessage(String value) {
        this.rawMessage = value;
    }

    /**
     * 获取rawReason属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRawReason() {
        return rawReason;
    }

    /**
     * 设置rawReason属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRawReason(String value) {
        this.rawReason = value;
    }

    /**
     * 获取rawCause属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRawCause() {
        return rawCause;
    }

    /**
     * 设置rawCause属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRawCause(String value) {
        this.rawCause = value;
    }

    /**
     * 获取rawRemedy属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRawRemedy() {
        return rawRemedy;
    }

    /**
     * 设置rawRemedy属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRawRemedy(String value) {
        this.rawRemedy = value;
    }

    /**
     * Gets the value of the messageData property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the messageData property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getMessageData().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getMessageData() {
        if (messageData == null) {
            messageData = new ArrayList<String>();
        }
        return this.messageData;
    }

}
