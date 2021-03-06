package org.apache.lucene.search.caches;

import java.io.IOException;
import java.io.File;
import java.util.Hashtable;

import org.apache.lucene.index.IndexReader;


/**
 * Initialize and manages caches
 * @author Miguel Costa
 */
public class PwaCacheManager {
	
	/** multiple caches */
	private static Hashtable<String,PwaICache> caches=null;
	private static Object lockObj=new Object();
	private static PwaCacheManager instance=null; // singleton class
	
	
	/**
	 * Constructor	 
	 * @param reader index reader
	 * @param blacklistDir blacklist directory
	 */
	private PwaCacheManager(IndexReader reader, File blacklistFile) throws IOException {
		System.out.println("Initializing caches at "+this.getClass().getSimpleName()+" class.");
		caches=new Hashtable<String,PwaICache>();
		
		// blacklist of documents
		PwaICache cache=new PwaBlacklistCache(reader,blacklistFile); 		
		caches.put(cache.getFieldName(),cache);
		/* TODO remove - this data is not used anymore
		// indicates if it is a new version
		cache=new PwaDigestDiffCache(reader); 
		caches.put(cache.getFieldName(),cache);		
		// version group
		cache=new PwaUrlRadicalIdCache(reader); 	
		caches.put(cache.getFieldName(),cache);
		*/				
		// documents' timestamps
		cache=new PwaDateCache(reader);
		caches.put(cache.getFieldName(),cache);	
		
		// intialize index stats
		PwaIndexStats.getInstance(reader);
		// initialize stopwords
		PwaStopwords.getInstance(reader);
		
		System.out.println("Initializing caches at "+this.getClass().getSimpleName()+" class ended.");
	}	
	
	/**
	 * Get instance
	 * @param reader index reader
	 * @return
	 * @throws IOException
	 */
	public static PwaCacheManager getInstance(IndexReader reader) throws IOException {
		return getInstance(reader,null);
	}
	
	/**
	 * Get instance
	 * @param reader index reader
	 * @param blacklistDir blacklist directory
	 * @return
	 * @throws IOException
	 */
	public static PwaCacheManager getInstance(IndexReader reader, File blacklistFile) throws IOException {
		if (instance!=null) {
			return instance;
		}
		
		synchronized(lockObj) {
			if (instance!=null) {
				return instance;
			}
			instance=new PwaCacheManager(reader,blacklistFile);			
		}
		return instance;
	}
	
	/**
	 * Get value from cache
	 * @param fieldName field name cached
	 * @param doc document id
	 * @return
	 */
	public Object getValue(String fieldName, int doc) {
		if (caches.get(fieldName)==null) {
			return null;
		}
		return caches.get(fieldName).getValue(doc);
	}		
}
