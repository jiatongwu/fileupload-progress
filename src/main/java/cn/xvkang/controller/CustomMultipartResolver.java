package cn.xvkang.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 
 * 创建人：fantasy <br>
 * 创建时间：2013-12-6 <br>
 * 功能描述：文件上传Resolver <br>
 *
 */
public class CustomMultipartResolver extends CommonsMultipartResolver {

	// private HttpServletRequest request;

	protected FileUpload newFileUpload(FileItemFactory fileItemFactory) {
		return new ServletFileUpload(fileItemFactory);
	}

	public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) throws MultipartException {
		// 获取到request,要用到session
		// this.request = request;

		MultipartHttpServletRequest resolveMultipart = super.resolveMultipart(request);

		return resolveMultipart;

	}

	@Override
	public MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {

		String key = request.getParameter("uuid");
		String totalItems = request.getParameter("totalItems");
		HttpSession session = request.getSession();

		String encoding = determineEncoding(request);
		FileUpload fileUpload = prepareFileUpload(encoding);
		FileUploadProgressListener progressListener = null;
		if (StringUtils.isNotBlank(key) && StringUtils.isNotBlank(totalItems) && StringUtils.isNumeric(totalItems)) {
			progressListener = new FileUploadProgressListener(session, key, Integer.parseInt(totalItems));
			fileUpload.setProgressListener(progressListener);
		}

		try {
			List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
			return parseFileItems(fileItems, encoding);
		} catch (FileUploadBase.SizeLimitExceededException ex) {
			throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
		} catch (FileUploadException ex) {
			throw new MultipartException("Could not parse multipart servlet request", ex);
		}
	}
}