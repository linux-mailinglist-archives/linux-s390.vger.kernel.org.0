Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4B7E047C
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKCOOy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKCOOx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125BD4C;
        Fri,  3 Nov 2023 07:14:50 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3DtccL017982;
        Fri, 3 Nov 2023 14:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xmU715QNgpJ7EizqMBgj6/SXS1PcG48M+hoBySAplfY=;
 b=ZoD5c9ZLDuNyarFA4oKfvWijhVuztooiixqxGBQCZ9sA65VLTkbK6xJtXGFa+DrVAO42
 JMh70hcCDi/26teFG8UEHIai/9trzS7oDmlSQoHvcaxjy3FI7PNV2ex8aRyXbAs86qwH
 vdy0Xg20N7IZfSyDMc8DO4AE2wpfonT8V2qE0QFUIgp0ISof1EGgnQm+8QTLo13ZXzOI
 2e7gxgUwHDrYTQt2aBxigO7V/iuXkN16KnpP1rx6ERde/Kvn62baibCZ7/sA//QJCM5L
 sl6AdjV4Wud8OkWYi7XZpJo5vosAd6+ZrNhyZ6C/bxHBmGw/uo6GlbkAASwqOspE0xPW WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u525ygqa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:49 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3Dtf56018040;
        Fri, 3 Nov 2023 14:14:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u525ygmab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3E2ISg000591;
        Fri, 3 Nov 2023 14:14:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmtpqr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 14:14:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3EE7Wt25297416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 14:14:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73E002004B;
        Fri,  3 Nov 2023 14:14:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 449EA20040;
        Fri,  3 Nov 2023 14:14:07 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 14:14:07 +0000 (GMT)
Date:   Fri, 3 Nov 2023 14:57:43 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v7 6/8] s390x: add test source dir to
 include paths
Message-ID: <20231103145743.70754de2@p-imbrenda>
In-Reply-To: <20231103092954.238491-7-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
        <20231103092954.238491-7-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q_5riM245Q7Wkq1hG-VhuXafvIXvT_X5
X-Proofpoint-GUID: nJTtdoQhK0ikqx8N-gvBIsTwSBJZE1ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
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

On Fri,  3 Nov 2023 10:29:35 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Sometimes, it is useful to share some defines between a snippet and a
> test. By adding the source directory to include paths, header files can
> be placed in the snippet directory and included from the test (or vice
> versa).
> 
> This is a prerequisite for "s390x: add a test for SIE without MSO/MSL".
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  s390x/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 6e967194ae0d..947a4344738f 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -67,7 +67,7 @@ test_cases: $(tests)
>  test_cases_binary: $(tests_binary)
>  test_cases_pv: $(tests_pv_binary)
>  
> -INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x
> +INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x $(SRCDIR)/s390x
>  # Include generated header files (e.g. in case of out-of-source builds)
>  INCLUDE_PATHS += lib
>  CPPFLAGS = $(addprefix -I,$(INCLUDE_PATHS))

