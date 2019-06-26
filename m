Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB23F5663B
	for <lists+linux-s390@lfdr.de>; Wed, 26 Jun 2019 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZKHK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 Jun 2019 06:07:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZKHK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jun 2019 06:07:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QA3wqO075868;
        Wed, 26 Jun 2019 10:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=EXffVoBobeDaVKXoPY92BE6hNb96CP1V405UthDvjlA=;
 b=C6+PvCwj0WOnPVICyU2EKtSq2nK5KqRm6HSY5XzkZTgjTJ46X9DcDH+HCqX/k5TJJX7S
 VGGJXnHTTaF+KNhetL4mzpG5nvAl6kNeVPlv7mGRllymsT8lEjpttAxQil7HqEI7tCPS
 5UK33tqw6liSjKljLGMALc8/fmSBOWMjRbRzGmKAWknJpHcYF2ET3DAuT+2+r6G2w8ce
 kY8QyDvgUKdwpy10F2bjTGc/sNvfAqqHNWAeWnPjZ8uyRd01LpvblQPI70O/e/uP5ojP
 Ejg1nyQXRnortl26Wj/+UOmQI5HOWHh2hkSNmHfFLTwn97fs91qROUDt6NDycBTINt5p pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqharf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 10:07:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QA5sbT033578;
        Wed, 26 Jun 2019 10:07:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f4cpcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 10:07:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QA75AF003386;
        Wed, 26 Jun 2019 10:07:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 03:07:05 -0700
Date:   Wed, 26 Jun 2019 13:06:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] s390/dasd: Fix a precision vs width bug in
 dasd_feature_list()
Message-ID: <20190626100658.GB3242@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260121
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The "len" variable is the length of the option up to the next option or
to the end of the string which ever first.  We want to print the invalid
option so we want precision "%.*s" but the format is width "%*s" so it
prints up to the end of the string.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

 drivers/s390/block/dasd_devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index fab35c6170cc..245f33c2f71e 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -203,7 +203,7 @@ static int __init dasd_feature_list(char *str)
 		else if (len == 8 && !strncmp(str, "failfast", 8))
 			features |= DASD_FEATURE_FAILFAST;
 		else {
-			pr_warn("%*s is not a supported device option\n",
+			pr_warn("%.*s is not a supported device option\n",
 				len, str);
 			rc = -EINVAL;
 		}
-- 
2.20.1

