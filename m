Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3B1623E3
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2020 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRJvF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Feb 2020 04:51:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgBRJvF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:51:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9nTwi015637
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:51:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y87e6bp57-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:51:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 18 Feb 2020 09:51:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 09:51:00 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01I9oxxK45875204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:50:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A83211C064;
        Tue, 18 Feb 2020 09:50:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E25011C050;
        Tue, 18 Feb 2020 09:50:59 +0000 (GMT)
Received: from [9.152.212.29] (unknown [9.152.212.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 09:50:58 +0000 (GMT)
Subject: Re: [RFC v2 0/2] fces event support in cio
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
References: <20200218092317.49846-1-vneethv@linux.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 18 Feb 2020 10:50:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200218092317.49846-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021809-0016-0000-0000-000002E7E2C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021809-0017-0000-0000-0000334AF5D9
Message-Id: <8fddc7ba-5032-4c6f-4e9f-8dcf2fb6facf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=912
 lowpriorityscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180079
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.02.2020 10:23, Vineeth Vijayan wrote:
> Compared to the previous version of this RFC(RFC v1 0/2] support
> FC-Endpoint Security events), there is a change in the information we
> passed to the consumer-devices using path-event. 
> 
> Previously we used to share the exact event of fces, which is derived
> from the sei_area->ccdf[0]. In this patch, instead of sending the right
> event, simply inform the ccwdev about the occurance of 'fces event'
> using path_event. The ccwdev then query more information about the
> fces-event using the chsc_scud() call and notify based on the reply.
> 
> Sebastian Ott (1):
>   s390/cio: handle changes related to endpoint security
> 
> Vineeth Vijayan (1):
>   s390/cio: add support for fces status notification
> 
>  arch/s390/include/asm/ccwdev.h |  1 +
>  drivers/s390/cio/chp.h         |  1 +
>  drivers/s390/cio/chsc.c        | 73 ++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/device.c      | 19 ++++++++-
>  4 files changed, 93 insertions(+), 1 deletion(-)

Please disregard this RFC for now - the patches need some more internal
discussions before they are ready for external review.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

