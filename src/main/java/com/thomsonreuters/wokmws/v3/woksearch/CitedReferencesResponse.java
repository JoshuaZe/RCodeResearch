
package com.thomsonreuters.wokmws.v3.woksearch;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>citedReferencesResponse complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="citedReferencesResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="return" type="{http://woksearch.v3.wokmws.thomsonreuters.com}citedReferencesSearchResults" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "citedReferencesResponse", propOrder = {
    "_return"
})
public class CitedReferencesResponse {

    @XmlElement(name = "return")
    protected CitedReferencesSearchResults _return;

    /**
     * 获取return属性的值。
     * 
     * @return
     *     possible object is
     *     {@link CitedReferencesSearchResults }
     *     
     */
    public CitedReferencesSearchResults getReturn() {
        return _return;
    }

    /**
     * 设置return属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link CitedReferencesSearchResults }
     *     
     */
    public void setReturn(CitedReferencesSearchResults value) {
        this._return = value;
    }

}
