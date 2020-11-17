Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808582B6DA8
	for <lists+linux-s390@lfdr.de>; Tue, 17 Nov 2020 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKQSop (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Nov 2020 13:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45424 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgKQSop (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:44:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIXGGH009364
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SEiTt0yIaZwejevo8Yoq4LmOYXsKgV+j4I2ca487ytw=;
 b=dpYt+2uiBo559N0tHo8YRCuU2SHVynL6tm4/6NM8wOzk4nPwMGO5QGO4JgKmZiogjp6g
 yT9ET2V8lZS759V/HkyGQ5obxjYzjaOYUQzSGi+vFaiVnP9uVJ+3PAKYXJRu1HfkQ5PT
 7R7kc5fJhkBET57DomdiSPi0W0PF2e0SA1ti9xZ+/OBn+LI0QphpIJsqBMKArbnq+i2j
 qlqwbd1lW6mXu9ZNKG5KbCI1FkNnIxl2fmoatHeFhenIY2O80x9xuB8c3/JshyeIaAoI
 3nrZXAicF0jwYSlylLY+ilxzF8EI2bAd/yMrPF37Fjox9WsgeIeyTsIS5Uc0A1RfaCmG Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vdn5u7tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:43 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIXL7f009551
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:43 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vdn5u7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:44:43 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIhTmR017823;
        Tue, 17 Nov 2020 18:44:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8bcee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:44:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHIid9255378282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:44:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA8ED11C054;
        Tue, 17 Nov 2020 18:44:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8DA511C050;
        Tue, 17 Nov 2020 18:44:38 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Nov 2020 18:44:38 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:44:37 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/3] s390/vmem: make variable and function names
 consistent
Message-ID: <20201117184437.GF4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_07:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=780 mlxscore=0
 suspectscore=1 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170133
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 10:36:23AM +0100, Alexander Gordeev wrote:
> Rename some variable and functions to better clarify
> what they are and what they do.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/vmem.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.
