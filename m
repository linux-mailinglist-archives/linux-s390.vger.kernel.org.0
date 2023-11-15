Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522D57E047D
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 15:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjKCOPf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjKCOPd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:15:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97C1BC;
        Fri,  3 Nov 2023 07:15:31 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Dtbch017956;
        Fri, 3 Nov 2023 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=DWrLRR93nCEgNf3zG7belu3flkjlrSb6qJTbJCuEXnE=;
 b=rFhZ4e/Ij8eKhIVZQNxPdRPkpZ6lM6E6iaG5krBio5573TyTu/wpEm40VZKfBW7h0rKs
 CfrJCQ2DDEm/kzJxdhc/eY6Uatbcq611CQuKR+7r0zG+w3wdqDfiFaqiUza4N/xyB7Dx
 i9Ld+t3amRVh2mzX1cS4i1nMzqtT1YR+grDjNFv9gXuebz3izv3f+7oPol60W4DkeX2D
 ywb4o9kXl0ytVJSI97rhHtn5mjnMXXaqstEkeIm+JtIG9FjeJ9Y+2oeUFG7T+E7x6wmp
 +8c4NBWjko3DWTVJYTUo/4yieY4h+et5VpPapNKeNWputPapKZv4nB7dnT9jpMc2DiYH Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u525ygqfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:15:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3EEECZ024140;
        Fri, 3 Nov 2023 14:14:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u525ygmdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DRAZN031403;
        Fri, 3 Nov 2023 14:14:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2nwga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3EE8Vq17302052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 14:14:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAAC12004B;
        Fri,  3 Nov 2023 14:14:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9891220040;
        Fri,  3 Nov 2023 14:14:08 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 14:14:08 +0000 (GMT)
Date:   Fri, 3 Nov 2023 15:14:02 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v7 8/8] lib: s390x: interrupt: remove
 TEID_ASCE defines
Message-ID: <20231103151402.002787c3@p-imbrenda>
In-Reply-To: <20231103092954.238491-9-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
        <20231103092954.238491-9-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -8SK4nwDhB4ivMXXVJKJfaKpTJ3e8Xz0
X-Proofpoint-GUID: mVMI8EcSRv7CYFf9vfTnsazdRUb5Z1A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=971 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311030120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  3 Nov 2023 10:29:37 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> These defines were - I can only guess - meant for the asce_id field.
> Since print_decode_teid() used AS_PRIM and friends instead, I see little
> benefit in keeping these around.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  lib/s390x/asm/interrupt.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
> index 7f73d473b346..48bd78fa1515 100644
> --- a/lib/s390x/asm/interrupt.h
> +++ b/lib/s390x/asm/interrupt.h
> @@ -13,11 +13,6 @@
>  #define EXT_IRQ_EXTERNAL_CALL	0x1202
>  #define EXT_IRQ_SERVICE_SIG	0x2401
>  
> -#define TEID_ASCE_PRIMARY	0
> -#define TEID_ASCE_AR		1
> -#define TEID_ASCE_SECONDARY	2
> -#define TEID_ASCE_HOME		3
> -
>  union teid {
>  	unsigned long val;
>  	union {

