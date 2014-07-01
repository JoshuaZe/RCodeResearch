package cn.iselab.restopicer.petwosclient;

import java.util.ArrayList;
import java.util.List;

import com.thomsonreuters.wokmws.cxf.auth.WOKMWSAuthenticate_WOKMWSAuthenticatePort_Client;
import com.thomsonreuters.wokmws.v3.woksearch.EditionDesc;
import com.thomsonreuters.wokmws.v3.woksearch.FullRecordData;
import com.thomsonreuters.wokmws.v3.woksearch.FullRecordSearchResults;
import com.thomsonreuters.wokmws.v3.woksearch.KeyValuePair;
import com.thomsonreuters.wokmws.v3.woksearch.QueryParameters;
import com.thomsonreuters.wokmws.v3.woksearch.RetrieveParameters;
import com.thomsonreuters.wokmws.v3.woksearch.SortField;
import com.thomsonreuters.wokmws.v3.woksearch.TimeSpan;
import com.thomsonreuters.wokmws.v3.woksearch.ViewField;
import com.thomsonreuters.wokmws.v3.woksearch.WokSearch_WokSearchPort_Client;

/**
 * WOSClientPet
 * one query one task one SID!
 * @author Joshua Z
 */
public class WOSClientPet {
	//Singleton WOKMWSAuthenticate_WOKMWSAuthenticatePort_Client
    private WOKMWSAuthenticate_WOKMWSAuthenticatePort_Client WOKMWSAuthenticate_Client = 
    										WOKMWSAuthenticate_WOKMWSAuthenticatePort_Client.getInstance();
	//Session Identifier
    private String _session_identifier;
	private void set_session_identifier(String _session_identifier) {
		this._session_identifier = _session_identifier;
		WOKMWSAuthenticate_Client.setSIDForPort(_session_identifier);
		WokSearch_Client.setSIDForPort(_session_identifier);
	}
	/**
     * apply_session_identifier
     * @return WOSClientPet
     * @author Joshua
     * 
     */
    public WOSClientPet apply_session_identifier() {
		if(_session_identifier==null){
			set_session_identifier(WOKMWSAuthenticate_Client.authenticate());
		}
		return this;
	}
    /**
     * remove_session_identifier
     * @author Joshua
     * 
     */
    public void remove_session_identifier() {
		if(_session_identifier!=null){
			WOKMWSAuthenticate_Client.closeSession(_session_identifier);
			set_session_identifier(null);
		}
	}

    //Singleton WokSearch_WokSearchPort_Client
    private WokSearch_WokSearchPort_Client WokSearch_Client = WokSearch_WokSearchPort_Client.getInstance();
    
    //Search QueryParameters
    private QueryParameters _search_queryParameters = new QueryParameters();
    /**
     * QueryParameters
     * config_search_queryParameters
     * @return Boolean
     * @author Joshua
     * 
     */
	private Boolean config_search_queryParameters(){
		if(_search_queryParameters.getDatabaseId()==null){
			_search_queryParameters.setDatabaseId("WOS");
		}
		if(_search_queryParameters.getQueryLanguage()==null){
			_search_queryParameters.setQueryLanguage("en");
		}
		if(_search_queryParameters.getTimeSpan()==null){
			return Boolean.FALSE;
		}
		if(_search_queryParameters.getUserQuery()==null){
			return Boolean.FALSE;
		}
		if(_search_queryParameters.getEditions().isEmpty()){
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}
	/**
	 * QueryParameters
     * setDatabaseId
     * @default WOS
     * @deprecated
     * @param databaseId
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setDatabaseId(String databaseId) {
		_search_queryParameters.setDatabaseId(databaseId);
		return this;
	}
	/**
	 * QueryParameters
     * setUserQuery
     * @param userQuery
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setUserQuery(String userQuery) {
		_search_queryParameters.setUserQuery(userQuery);
		return this;
	}
	/**
	 * QueryParameters
     * addEdition
     * @param collection
     * @param edition
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet addEdition(String collection,String edition) {
		EditionDesc editionDesc = new EditionDesc();
		editionDesc.setCollection(collection);
		editionDesc.setEdition(edition);
		_search_queryParameters.getEditions().add(editionDesc);
		return this;
	}
	/**
	 * QueryParameters
     * setSymbolicTimeSpan
     * @deprecated
     * @param symbolicTimeSpan(1week,2week,4week)
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setSymbolicTimeSpan(String symbolicTimeSpan) {
		_search_queryParameters.setSymbolicTimeSpan(symbolicTimeSpan);
		return this;
	}
	/**
	 * QueryParameters
     * setTimeSpan
     * @param begin(YYYY-MM-DD)
     * @param end(YYYY-MM-DD)
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setTimeSpan(String begin,String end) {
		TimeSpan timeSpan =new TimeSpan();
		timeSpan.setBegin(begin);
		timeSpan.setEnd(end);
		_search_queryParameters.setTimeSpan(timeSpan);
		return this;
	}
	/**
	 * QueryParameters
     * setQueryLanguage
     * @default en
     * @param queryLanguage
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setQueryLanguage(String queryLanguage) {
		_search_queryParameters.setQueryLanguage(queryLanguage);
		return this;
	}
	/**
	 * RetrieveParameters
     * generate_retrieveParameters
     * If count is 0 then only the summary information will be returned
     * @param firstRecord
     * @param recordsFound
     * @return RetrieveParameters
     * @author Joshua
     * 
     */
	private RetrieveParameters generate_retrieveParameters(int firstRecord,int recordsFound){
		RetrieveParameters retrieveParameters = new RetrieveParameters();
		if(firstRecord>startRecord){
			retrieveParameters.setFirstRecord(firstRecord);
		}else{
			retrieveParameters.setFirstRecord(startRecord);
		}
		if(recordsFound<firstRecord){
			retrieveParameters.setCount(0);
		}else if((recordsFound-firstRecord+1)>maxcountofeach){
			retrieveParameters.setCount(maxcountofeach);
		}else{
			retrieveParameters.setCount(recordsFound-firstRecord+1);
		}
		if(sortFields.isEmpty()){
			this.addSortField("TC","D");	
		}
		retrieveParameters.getSortField().addAll(sortFields);
		if(!option.isEmpty()){
			retrieveParameters.getOption().addAll(option);
		}
		return retrieveParameters;
	}
	
	private int next_firstRecord(int last_firstRecord,int last_count){
		return last_firstRecord+last_count;
	}
	//Query Information for RetrieveParameters
	private int startRecord = 1;
	/**
	 * RetrieveParameters
     * setStartRecord
     * @default 1
     * @param startRecord
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setStartRecord(int startRecord) {
		this.startRecord = startRecord;
		return this;
	}
	private int maxcountofeach = 100;
	/**
	 * RetrieveParameters
     * setMaxcountofeach
     * If count is 0 then only the summary information will be returned
     * @default 100
     * @param maxcountofeach
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setMaxcountofeach(int maxcountofeach) {
		this.maxcountofeach = maxcountofeach;
		return this;
	}
	private List<SortField> sortFields = new ArrayList<SortField>();
	/**
	 * RetrieveParameters
     * addSortField
     * @default TC-D
     * @param name(TC)
     * @param sort(D)
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet addSortField(String name,String sort) {
		SortField sortField = new SortField();
		sortField.setName(name);
		sortField.setSort(sort);
		this.sortFields.add(sortField);
		return this;
	}
	private List<ViewField> viewFields = new ArrayList<ViewField>();
	/**
	 * RetrieveParameters
     * addViewField
     * If the viewField parameter is omitted, then all record data are returned.
     * @deprecated
     * @param maxcountofeach
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet addViewField(String fieldName) {
		if(viewFields.isEmpty()){
			ViewField viewField = new ViewField();
			viewField.setCollectionName("WOS");
			viewField.getFieldName().add(fieldName);
			viewFields.add(viewField);
		}else{
			viewFields.get(0).getFieldName().add(fieldName);
		}
		return this;
	}
	private List<KeyValuePair> option = new ArrayList<KeyValuePair>();
	/**
	 * RetrieveParameters
     * addOption
     * @param key
     * @param value
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	private WOSClientPet addOption(String key,String value) {
		KeyValuePair pair = new KeyValuePair();
		pair.setKey(key);
		pair.setValue(value);
		this.option.add(pair);
		return this;
	}
	/**
	 * RetrieveParameters
     * setRecordIDsOn
     * @default
     * @param ON
     * @return WOSClientPet
     * @author Joshua
     * 
     */
	public WOSClientPet setRecordIDsOn() {
		addOption("RecordIDs","On");
		return this;
	}
	
	//FullRecordSearchResults
	private FullRecordSearchResults searchMetaInfo;
	public WOSClientPet task_process(){
		if(!config_search_queryParameters()){
			System.out.println("config_search_queryParameters return false!");
			return this;
		}
		searchMetaInfo = WokSearch_Client.search(_search_queryParameters, generate_retrieveParameters(1,0));
		System.out.println(searchMetaInfo.getQueryId());
		System.out.println(searchMetaInfo.getRecordsFound());
		System.out.println(searchMetaInfo.getRecordsSearched());
		//retrieve
		RetrieveParameters retrieveParameters = generate_retrieveParameters(1,searchMetaInfo.getRecordsFound());
		while(retrieveParameters.getFirstRecord()<searchMetaInfo.getRecordsFound()){
			FullRecordData record_result = new FullRecordData();
			record_result = WokSearch_Client.retrieve(searchMetaInfo.getQueryId(), retrieveParameters);
			retrieveParameters = generate_retrieveParameters(next_firstRecord(retrieveParameters.getFirstRecord(), retrieveParameters.getCount()),searchMetaInfo.getRecordsFound());
			//do sth on record_result
			
			System.out.println(record_result.getRecords());
		}
		//reference
		return this;
	}
}
