Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978C2C2175
	for <lists+linux-s390@lfdr.de>; Tue, 24 Nov 2020 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgKXJeO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Nov 2020 04:34:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgKXJeO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 04:34:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9WARr011799
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=F0joviIwnKkZuQzA2SpcgA1QkDs/8S5As4+lEuppGi4=;
 b=T37R22QJeQNtUCYXid0W3coG7ezzxFcmfB5OK2iz2SprOZo0NwmnryU9ExJ9Hh3yzQGs
 qSyFwHD3JqM9mpPxnnIdHB9vrJgkWI9z3+5aYY0Wz919MPa4EdQIEeQbatWZloKSMpxX
 VIL0Z76/8LUX6ESwXlCWfIo3cijoGCA+HJ8/FsrvWLJ8zCaqVzAVkwsnXAovNauwzfLS
 pKjC3AAd/4Dsa3nIylePSbctDCTHYF7H2iT3ZOIt59dKGogHcJcTFtbViROAE76LB+/i
 3jHpsz60/hsizTtIuqJr7u44qZaYQD/jVdH/x794C29B/zPaWOJepL3WXRCVRbRVK26M ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350rkp4xbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO9WI2l012347
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:13 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350rkp4xb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 04:34:13 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9XXGe026530;
        Tue, 24 Nov 2020 09:34:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hbem4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 09:34:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AO9Y87a61407642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 09:34:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C33AE053;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B954AE05A;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, farman@linux.ibm.com,
        fiuczy@linux.ibm.com
Subject: [RFC 0/1] Remove uevent suppression logic from css driver
Date:   Tue, 24 Nov 2020 10:34:06 +0100
Message-Id: <20201124093407.23189-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_03:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=605 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This RFC is a follow-up for the below mentioned thread.
https://marc.info/?l=linux-s390&m=158591045732735&w=2

As mentioned in the RFD, we tried to remove the uevent suppression
logic from the css driver. I think this would help the vfio-cww 
udev-rules to bind to the subchannel before the io-subchanneli driver.

Here, the uevent is generated after,stsch() and css_sch_is_valid() 
which makes sure that the subchannel is valid.


Vineeth Vijayan (1):
  s390/cio: Remove uevent-suppress from css driver

 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

-- 
2.17.1

