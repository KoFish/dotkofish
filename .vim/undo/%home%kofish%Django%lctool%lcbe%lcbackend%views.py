Vim�UnDo� �xp"W?����i�R����~��l�!T�G��g                                    Q&    _�                     	        ����                                                                                                                                                                                                                                                                                                                            '          .          V       Q&o     �   	         �   	   
      5�_�                    
       ����                                                                                                                                                                                                                                                                                                                            (          /          V       Q&q     �   	           5from lcbackend.models import LCVariable, NodeVariable5�_�                    (        ����                                                                                                                                                                                                                                                                                                                            (          /          V       Q&w    �   '   (       
   def _lgr_uri_to_items(lc):       lgr = {   X        'subjects': [get_item_by_uri(subject.uri) for subject in lc.subjects_uri.all()],   h        'educationlevels': [get_item_by_uri(edulevel.uri) for edulevel in lc.educationlevels_uri.all()],   H        'syfte': [get_item_by_uri(sy.uri) for sy in lc.syfte_uri.all()],   ^        'centraltinnehall': [get_item_by_uri(ci.uri) for ci in lc.centraltinnehall_uri.all()],       }       return lgr        5�_�                    '        ����                                                                                                                                                                                                                                                                                                                            (          (          V       Q&z    �   &   '           5�_�                     &        ����                                                                                                                                                                                                                                                                                                                            '          '          V       Q&~    �   &   (      5��