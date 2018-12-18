package cn.xvkang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * 创建人：fantasy <br>
 * 创建时间：2013-12-6 <br>
 * 功能描述： 获取上传文件进度controller<br>
 *
 */
@RestController
public class ProgressController {

	@RequestMapping(value = "/upfile/progress", method = RequestMethod.GET)
	public String initCreateInfo(HttpServletRequest request, String key) {
		Progress status = (Progress) request.getSession().getAttribute(key);
		if (status == null) {
			return "{}";
		}
		return status.toString();
	}

	@RequestMapping(value = "/upfile/upload", method = RequestMethod.POST)
	public String upload(HttpServletRequest request, String name, MultipartFile file01, MultipartFile file02)
			throws IOException {

		InputStream inputStream1 = file01.getInputStream();
		IOUtils.copy(inputStream1,
				new FileOutputStream(new File("/Users/wu/Desktop/" + UUID.randomUUID().toString() + ".iso")));

		InputStream inputStream2 = file02.getInputStream();
		IOUtils.copy(inputStream2,
				new FileOutputStream(new File("/Users/wu/Desktop/" + UUID.randomUUID().toString() + ".iso")));

		return "ok";
	}

	@RequestMapping(value = "/upfile/uploadMulti", method = RequestMethod.POST)
	public String uploadMulti(HttpServletRequest request, String name, List<MultipartFile> file) throws IOException {
		for (MultipartFile tmpFile : file) {
			InputStream inputStream1 = tmpFile.getInputStream();
			IOUtils.copy(inputStream1,
					new FileOutputStream(new File("/Users/wu/Desktop/" + UUID.randomUUID().toString() + ".iso")));
		}
		return "ok";
	}
}