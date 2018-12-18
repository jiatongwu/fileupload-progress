package cn.xvkang.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;

/**
 * 
 * 创建人：fantasy <br>
 * 创建时间：2013-12-6 <br>
 * 功能描述： 文件上传进度<br>
 */
public class FileUploadProgressListener implements ProgressListener {

	private HttpSession session;
	private String key;
	private int totalItem;

	public FileUploadProgressListener() {
	}

	public FileUploadProgressListener(HttpSession session, String key, int totalItem) {
		this.session = session;
		Progress status = new Progress();
		this.key = key;
		this.totalItem = totalItem;
		session.setAttribute(key, status);
	}

	/**
	 * pBytesRead 到目前为止读取文件的比特数 pContentLength 文件总大小 pItems 目前正在读取第几个文件
	 */
	public void update(long pBytesRead, long pContentLength, int pItems) {
		Progress status = (Progress) session.getAttribute(key);
		if (status != null) {
			status.setBytesRead(pBytesRead);
			status.setContentLength(pContentLength);
			status.setItems(pItems);
			session.setAttribute(key, status);
		} else {
			System.out.println("bug");
			System.out.println("bug");
			System.out.println("bug");
			System.out.println("bug");
			System.out.println("bug");
			System.out.println("bug");
		}
		if (pBytesRead == pContentLength && pItems == totalItem) {
			session.removeAttribute(key);
		}
	}

	public int getTotalItem() {
		return totalItem;
	}

	public void setTotalItem(int totalItem) {
		this.totalItem = totalItem;
	}

}