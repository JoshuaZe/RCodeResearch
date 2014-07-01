
package com.thomsonreuters.wokmws.v3.woksearchlite;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 *       The FaultInformation is detail for the SOAP fault. This information did not exist in WokSearch version 2. However the Fault did 
 *       exist.  
 *       
 * 
 * <p>FaultInformation complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="FaultInformation">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="code" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="message" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="reason" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="causeType" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="cause" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="supportingWebServiceException" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}SupportingWebServiceException" minOccurs="0"/>
 *         &lt;element name="remedy" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FaultInformation", propOrder = {
    "code",
    "message",
    "reason",
    "causeType",
    "cause",
    "supportingWebServiceException",
    "remedy"
})
public class FaultInformation {

    @XmlElement(required = true)
    protected String code;
    protected String message;
    protected String reason;
    protected String causeType;
    protected String cause;
    protected SupportingWebServiceException supportingWebServiceException;
    protected String remedy;

    /**
     * 获取code属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCode() {
        return code;
    }

    /**
     * 设置code属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCode(String value) {
        this.code = value;
    }

    /**
     * 获取message属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMessage() {
        return message;
    }

    /**
     * 设置message属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMessage(String value) {
        this.message = value;
    }

    /**
     * 获取reason属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReason() {
        return reason;
    }

    /**
     * 设置reason属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReason(String value) {
        this.reason = value;
    }

    /**
     * 获取causeType属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCauseType() {
        return causeType;
    }

    /**
     * 设置causeType属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCauseType(String value) {
        this.causeType = value;
    }

    /**
     * 获取cause属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCause() {
        return cause;
    }

    /**
     * 设置cause属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCause(String value) {
        this.cause = value;
    }

    /**
     * 获取supportingWebServiceException属性的值。
     * 
     * @return
     *     possible object is
     *     {@link SupportingWebServiceException }
     *     
     */
    public SupportingWebServiceException getSupportingWebServiceException() {
        return supportingWebServiceException;
    }

    /**
     * 设置supportingWebServiceException属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link SupportingWebServiceException }
     *     
     */
    public void setSupportingWebServiceException(SupportingWebServiceException value) {
        this.supportingWebServiceException = value;
    }

    /**
     * 获取remedy属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemedy() {
        return remedy;
    }

    /**
     * 设置remedy属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemedy(String value) {
        this.remedy = value;
    }

}
