Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929B215BE87
	for <lists+linux-s390@lfdr.de>; Thu, 13 Feb 2020 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMMh5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 13 Feb 2020 07:37:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729673AbgBMMhz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 07:37:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DCZi0J035446
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 07:37:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3yw977su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 07:37:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 13 Feb 2020 12:37:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 12:37:48 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DCbkJR12583112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 12:37:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF0852054;
        Thu, 13 Feb 2020 12:37:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FBE052057;
        Thu, 13 Feb 2020 12:37:46 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Date:   Thu, 13 Feb 2020 13:37:26 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20021312-0020-0000-0000-000003A9C68C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021312-0021-0000-0000-00002201B132
Message-Id: <20200213123728.61216-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=969 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130098
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Two patches are handling new edge cases introduced by doing DMA mappings
(which can fail) in virtio core.

I stumbled upon this while stress testing I/O for Protected Virtual
Machines. I deliberately chose a tiny swiotlb size and have generated
load with fio. With more than one virtio-blk disk in use I experienced
hangs.

The goal of this series is to fix those hangs.

Halil Pasic (2):
  virtio-blk: fix hw_queue stopped on arbitrary error
  virtio-blk: improve virtqueue error to BLK_STS

 drivers/block/virtio_blk.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)


base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
-- 
2.17.1

