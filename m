Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135EF7D9FF
	for <lists+linux-s390@lfdr.de>; Thu,  1 Aug 2019 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfHALGh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Aug 2019 07:06:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbfHALGh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 07:06:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71B3hR8096177
        for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2019 07:06:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3x7f1thw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 07:06:35 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 1 Aug 2019 12:06:34 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 12:06:32 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71B6EDs34537768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 11:06:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC36AE059;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCEC6AE056;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 76690E02D9; Thu,  1 Aug 2019 13:06:30 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
Subject: [PATCH 0/1] sending DASD patches through linux-block
Date:   Thu,  1 Aug 2019 13:06:29 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19080111-0020-0000-0000-000003594D5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080111-0021-0000-0000-000021AD5C00
Message-Id: <20190801110630.82432-1-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010116
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

we would like to get our DASD related patches upstream through your
linux-block git tree in the future.
We hope to get a better integration and that we are able to identify
potential conflicts with generic blocklayer changes earlier.

I hope this is OK for you. I have attached a first patch that fixes a
bug in the DASD driver. This patch is based on the master branch of your
linux-block git tree.

Please let me know if I should change something in my workflow.

Kind regards,
Stefan

Stefan Haberland (1):
  s390/dasd: fix endless loop after read unit address configuration

 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.17.1

