
package com.thomsonreuters.wokmws.cxf.auth;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.thomsonreuters.wokmws.cxf.auth package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Authenticate_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "authenticate");
    private final static QName _InternalServerException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "InternalServerException");
    private final static QName _InvalidInputException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "InvalidInputException");
    private final static QName _CloseSession_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "closeSession");
    private final static QName _ESTIWSException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "ESTIWSException");
    private final static QName _AuthenticationException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "AuthenticationException");
    private final static QName _CloseSessionResponse_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "closeSessionResponse");
    private final static QName _AuthenticateResponse_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "authenticateResponse");
    private final static QName _SessionException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "SessionException");
    private final static QName _QueryException_QNAME = new QName("http://auth.cxf.wokmws.thomsonreuters.com", "QueryException");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.thomsonreuters.wokmws.cxf.auth
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Authenticate }
     * 
     */
    public Authenticate createAuthenticate() {
        return new Authenticate();
    }

    /**
     * Create an instance of {@link InvalidInputException }
     * 
     */
    public InvalidInputException createInvalidInputException() {
        return new InvalidInputException();
    }

    /**
     * Create an instance of {@link InternalServerException }
     * 
     */
    public InternalServerException createInternalServerException() {
        return new InternalServerException();
    }

    /**
     * Create an instance of {@link CloseSession }
     * 
     */
    public CloseSession createCloseSession() {
        return new CloseSession();
    }

    /**
     * Create an instance of {@link ESTIWSException }
     * 
     */
    public ESTIWSException createESTIWSException() {
        return new ESTIWSException();
    }

    /**
     * Create an instance of {@link AuthenticationException }
     * 
     */
    public AuthenticationException createAuthenticationException() {
        return new AuthenticationException();
    }

    /**
     * Create an instance of {@link CloseSessionResponse }
     * 
     */
    public CloseSessionResponse createCloseSessionResponse() {
        return new CloseSessionResponse();
    }

    /**
     * Create an instance of {@link AuthenticateResponse }
     * 
     */
    public AuthenticateResponse createAuthenticateResponse() {
        return new AuthenticateResponse();
    }

    /**
     * Create an instance of {@link QueryException }
     * 
     */
    public QueryException createQueryException() {
        return new QueryException();
    }

    /**
     * Create an instance of {@link SessionException }
     * 
     */
    public SessionException createSessionException() {
        return new SessionException();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Authenticate }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "authenticate")
    public JAXBElement<Authenticate> createAuthenticate(Authenticate value) {
        return new JAXBElement<Authenticate>(_Authenticate_QNAME, Authenticate.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link InternalServerException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "InternalServerException")
    public JAXBElement<InternalServerException> createInternalServerException(InternalServerException value) {
        return new JAXBElement<InternalServerException>(_InternalServerException_QNAME, InternalServerException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link InvalidInputException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "InvalidInputException")
    public JAXBElement<InvalidInputException> createInvalidInputException(InvalidInputException value) {
        return new JAXBElement<InvalidInputException>(_InvalidInputException_QNAME, InvalidInputException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CloseSession }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "closeSession")
    public JAXBElement<CloseSession> createCloseSession(CloseSession value) {
        return new JAXBElement<CloseSession>(_CloseSession_QNAME, CloseSession.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ESTIWSException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "ESTIWSException")
    public JAXBElement<ESTIWSException> createESTIWSException(ESTIWSException value) {
        return new JAXBElement<ESTIWSException>(_ESTIWSException_QNAME, ESTIWSException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AuthenticationException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "AuthenticationException")
    public JAXBElement<AuthenticationException> createAuthenticationException(AuthenticationException value) {
        return new JAXBElement<AuthenticationException>(_AuthenticationException_QNAME, AuthenticationException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CloseSessionResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "closeSessionResponse")
    public JAXBElement<CloseSessionResponse> createCloseSessionResponse(CloseSessionResponse value) {
        return new JAXBElement<CloseSessionResponse>(_CloseSessionResponse_QNAME, CloseSessionResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AuthenticateResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "authenticateResponse")
    public JAXBElement<AuthenticateResponse> createAuthenticateResponse(AuthenticateResponse value) {
        return new JAXBElement<AuthenticateResponse>(_AuthenticateResponse_QNAME, AuthenticateResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SessionException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "SessionException")
    public JAXBElement<SessionException> createSessionException(SessionException value) {
        return new JAXBElement<SessionException>(_SessionException_QNAME, SessionException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link QueryException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://auth.cxf.wokmws.thomsonreuters.com", name = "QueryException")
    public JAXBElement<QueryException> createQueryException(QueryException value) {
        return new JAXBElement<QueryException>(_QueryException_QNAME, QueryException.class, null, value);
    }

}
