
package com.thomsonreuters.wokmws.v3.woksearchlite;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>SupportingWebServiceException complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="SupportingWebServiceException">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="remoteNamespace" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="remoteOperation" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="remoteCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="remoteReason" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="handshakeCauseId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="handshakeCause" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SupportingWebServiceException", propOrder = {
    "remoteNamespace",
    "remoteOperation",
    "remoteCode",
    "remoteReason",
    "handshakeCauseId",
    "handshakeCause"
})
public class SupportingWebServiceException {

    protected String remoteNamespace;
    protected String remoteOperation;
    protected String remoteCode;
    protected String remoteReason;
    protected String handshakeCauseId;
    protected String handshakeCause;

    /**
     * 获取remoteNamespace属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemoteNamespace() {
        return remoteNamespace;
    }

    /**
     * 设置remoteNamespace属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemoteNamespace(String value) {
        this.remoteNamespace = value;
    }

    /**
     * 获取remoteOperation属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemoteOperation() {
        return remoteOperation;
    }

    /**
     * 设置remoteOperation属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemoteOperation(String value) {
        this.remoteOperation = value;
    }

    /**
     * 获取remoteCode属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemoteCode() {
        return remoteCode;
    }

    /**
     * 设置remoteCode属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemoteCode(String value) {
        this.remoteCode = value;
    }

    /**
     * 获取remoteReason属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemoteReason() {
        return remoteReason;
    }

    /**
     * 设置remoteReason属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemoteReason(String value) {
        this.remoteReason = value;
    }

    /**
     * 获取handshakeCauseId属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getHandshakeCauseId() {
        return handshakeCauseId;
    }

    /**
     * 设置handshakeCauseId属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setHandshakeCauseId(String value) {
        this.handshakeCauseId = value;
    }

    /**
     * 获取handshakeCause属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getHandshakeCause() {
        return handshakeCause;
    }

    /**
     * 设置handshakeCause属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setHandshakeCause(String value) {
        this.handshakeCause = value;
    }

}
