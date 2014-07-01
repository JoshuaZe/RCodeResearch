
package com.thomsonreuters.wokmws.v3.woksearchlite;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * In version 2, the sequence of the elements was authors, keywords, other, source, title and UT.
 *         In version 3, the sequence is: uid, title, source, authors, keywords and other.
 *         
 * 
 * <p>liteRecord complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="liteRecord">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="uid" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="title" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}labelValuesPair" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="source" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}labelValuesPair" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="authors" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}labelValuesPair" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="keywords" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}labelValuesPair" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="other" type="{http://woksearchlite.v3.wokmws.thomsonreuters.com}labelValuesPair" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "liteRecord", propOrder = {
    "uid",
    "title",
    "source",
    "authors",
    "keywords",
    "other"
})
public class LiteRecord {

    protected String uid;
    @XmlElement(nillable = true)
    protected List<LabelValuesPair> title;
    @XmlElement(nillable = true)
    protected List<LabelValuesPair> source;
    @XmlElement(nillable = true)
    protected List<LabelValuesPair> authors;
    @XmlElement(nillable = true)
    protected List<LabelValuesPair> keywords;
    @XmlElement(nillable = true)
    protected List<LabelValuesPair> other;

    /**
     * 获取uid属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUid() {
        return uid;
    }

    /**
     * 设置uid属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUid(String value) {
        this.uid = value;
    }

    /**
     * Gets the value of the title property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the title property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getTitle().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LabelValuesPair }
     * 
     * 
     */
    public List<LabelValuesPair> getTitle() {
        if (title == null) {
            title = new ArrayList<LabelValuesPair>();
        }
        return this.title;
    }

    /**
     * Gets the value of the source property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the source property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getSource().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LabelValuesPair }
     * 
     * 
     */
    public List<LabelValuesPair> getSource() {
        if (source == null) {
            source = new ArrayList<LabelValuesPair>();
        }
        return this.source;
    }

    /**
     * Gets the value of the authors property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the authors property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAuthors().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LabelValuesPair }
     * 
     * 
     */
    public List<LabelValuesPair> getAuthors() {
        if (authors == null) {
            authors = new ArrayList<LabelValuesPair>();
        }
        return this.authors;
    }

    /**
     * Gets the value of the keywords property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the keywords property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getKeywords().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LabelValuesPair }
     * 
     * 
     */
    public List<LabelValuesPair> getKeywords() {
        if (keywords == null) {
            keywords = new ArrayList<LabelValuesPair>();
        }
        return this.keywords;
    }

    /**
     * Gets the value of the other property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the other property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getOther().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LabelValuesPair }
     * 
     * 
     */
    public List<LabelValuesPair> getOther() {
        if (other == null) {
            other = new ArrayList<LabelValuesPair>();
        }
        return this.other;
    }

}
