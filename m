Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C28183115
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2020 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCLNSI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Mar 2020 09:18:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLNSH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 09:18:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CDGalg044329
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 09:18:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqjwny5w9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 09:18:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 12 Mar 2020 13:17:19 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Mar 2020 13:17:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CDHGXd46137612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 13:17:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B66711C050;
        Thu, 12 Mar 2020 13:17:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2824511C04C;
        Thu, 12 Mar 2020 13:17:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Mar 2020 13:17:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id D94DCE02CF; Thu, 12 Mar 2020 14:17:15 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 0/1] s390/dasd: fix data corruption
Date:   Thu, 12 Mar 2020 14:17:14 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20031213-0028-0000-0000-000003E3A5B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031213-0029-0000-0000-000024A8ED6F
Message-Id: <20200312131715.72621-1-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_05:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=1 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 mlxlogscore=741
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120072
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please find following patch that fixes a likely data corruption when using
devices with thin provisioning support.
As this is a severe issue I hope this will make it into RC6. If not, please
let me know.

Regards,
Stefan

Stefan Haberland (1):
  s390/dasd: fix data corruption for thin provisioned devices

 drivers/s390/block/dasd.c      |  27 +++++-
 drivers/s390/block/dasd_eckd.c | 163 +++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_int.h  |  15 ++-
 3 files changed, 193 insertions(+), 12 deletions(-)

-- 
2.17.1

