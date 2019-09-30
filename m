Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB05C2454
	for <lists+linux-s390@lfdr.de>; Mon, 30 Sep 2019 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfI3Pco (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Sep 2019 11:32:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731276AbfI3Pcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 11:32:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UFOB0I031360
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 11:32:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbm38h41w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 11:32:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 30 Sep 2019 16:32:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 16:32:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UFWbZd50266328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 15:32:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02A5511C04C;
        Mon, 30 Sep 2019 15:32:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968FD11C04A;
        Mon, 30 Sep 2019 15:32:36 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.183])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 15:32:36 +0000 (GMT)
Date:   Mon, 30 Sep 2019 17:32:34 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/cio: fix virtio-ccw DMA without PV
In-Reply-To: <20190930145607.GA18163@lst.de>
References: <20190930135310.26148-1-pasic@linux.ibm.com>
        <20190930145607.GA18163@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093015-0016-0000-0000-000002B21D8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093015-0017-0000-0000-00003312F9A7
Message-Id: <20190930173234.5251bcb8.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=680 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300156
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 30 Sep 2019 16:56:07 +0200
Christoph Hellwig <hch@lst.de> wrote:

> The code looks fine, but I still very much disagree with the workaround
> comments.  The different mask for allocations vs streaming mappings is
> exactly how the DMA API is intended to work.

Thanks for having a look! I already changed this but messed up the
amend with git :( I will send out a v2 shortly.

Regards,
Halil

