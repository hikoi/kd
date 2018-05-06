package welink.estate

import com.baidu.ueditor.define.BaseState
import com.baidu.ueditor.define.State
import com.google.common.base.Preconditions
import welink.common.UEditorService
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.MultipartFile
import org.apache.commons.io.FilenameUtils
import javax.annotation.Resource

import static com.google.common.base.Preconditions.checkNotNull

class ItemPublishController {

    @Resource
    UEditorService uEditorService
    def fileUploadService


    def handle() {

        Long communityId = -1

        def action = request.getParameter('action')

        if ('config' == action) {
            forward(action: 'config')
        } else if (action.startsWith('upload')) {
            JSONObject jsonConfig = Preconditions.checkNotNull(uEditorService, 'uEditorService').standard()

            String rootPath = servletContext.getRealPath("/");

            MultipartFile file = (MultipartFile) request.getFile('upfile')

            if (file == null) {
                file = (MultipartFile) request.getFile('file')
            }

            checkNotNull(file)

            // 上传的原图文件名
            def originalName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(System.getProperty("file.separator")) + 1)

            String yunPath = fileUploadService.upload(communityId, "ITEM-PUBLISH", 0, 0, 0, originalName, file.getInputStream(), null)

            State storageState = new BaseState(true)

            storageState.putInfo("url", yunPath);
            storageState.putInfo("type", FilenameUtils.getExtension(yunPath));
            storageState.putInfo("original", FilenameUtils.getName(yunPath));

            println('上传图片的内容:' + storageState.toJSONString())
            render storageState.toJSONString()
        } else {
            response.sendError(HttpURLConnection.HTTP_INTERNAL_ERROR)
        }

    }

}
