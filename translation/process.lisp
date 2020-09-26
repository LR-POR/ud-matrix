
(ql:quickload '(:yason :serapeum :alexandria))

(serapeum:with-open-files 
    ((in "csli-en.sent")
     (ou "csli-en-1.json" :direction :output :if-exists :supersede))
  (let ((data (loop for line = (read-line in nil nil)
		    while line
		    collect line)))
    (yason:encode (alexandria:alist-hash-table 
		   `(("model_id" . "en-pt") 
		     ("text" ,@(subseq data 0 1000))))
		  ou)))

(serapeum:with-open-files 
    ((in "csli-en.sent")
     (ou "csli-en-2.json" :direction :output :if-exists :supersede))
  (let ((data (loop for line = (read-line in nil nil)
		    while line
		    collect line)))
    (yason:encode (alexandria:alist-hash-table 
		   `(("model_id" . "en-pt") 
		     ("text" ,@(subseq data 1000))))
		  ou)))

(defun load-json (fn)
  (with-open-file (in fn)
    (yason:parse in)))

(with-open-file (out "csli-pt-1.sent" :direction :output :if-exists :supersede) 
	   (mapcar (lambda (e) 
		     (format out "~a~%" (gethash "translation" e))) 
		   (gethash "translations" (load-json "/Users/ar/work/ud-matrix/csli-pt-1.json"))))

(with-open-file (out "csli-pt-2.sent" :direction :output :if-exists :supersede) 
	   (mapcar (lambda (e) 
		     (format out "~a~%" (gethash "translation" e))) 
		   (gethash "translations" (load-json "/Users/ar/work/ud-matrix/csli-pt-2.json"))))



