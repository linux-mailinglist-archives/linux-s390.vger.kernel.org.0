Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED94C2B06
	for <lists+linux-s390@lfdr.de>; Thu, 24 Feb 2022 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBXLhI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 24 Feb 2022 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiBXLhG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Feb 2022 06:37:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CBD45;
        Thu, 24 Feb 2022 03:36:31 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OB0fWU003069;
        Thu, 24 Feb 2022 11:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cB80VAUguu4gmaxIRXNj5TbmhB8/7iienHoEkqSOq2U=;
 b=pG+rtL1d4+tM1yGhcrJeLXsCns8I79g5zfgfrQZ+UJchUdzIiPZtyo6LQwefncE9okl7
 naIcyKfgcBXh45DZm1mkvw68WCop3anKGciG9rBd8z169L+D1jLN5TUCu6PVBKNKMUOM
 cpGfbsr4cqSESILWv0nJ/NquWAjIkNxIGFNyF2kMqar5pg0bfF8e5OahtLOmIXh8F++i
 IbyoxjgAWYXSt4RUblGWsvdicZOjFBz+Zvp5iIlwz1Qnb8UW9uI+3aNKTiFuMWrGf2qQ
 h41I3mOd1YVKjplnJc11ER7cwxMz6+ZpYXk2nfdwve6YaFOCgCoVo/e2hGuPSfknLfdt IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edw51eegp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 11:36:28 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21OBZaqu014531;
        Thu, 24 Feb 2022 11:36:28 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edw51eefy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 11:36:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21OBWlTD013135;
        Thu, 24 Feb 2022 11:36:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69h401-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 11:36:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21OBaNae56164782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 11:36:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2147C11C05C;
        Thu, 24 Feb 2022 11:36:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F42A11C054;
        Thu, 24 Feb 2022 11:36:22 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.2.54])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Feb 2022 11:36:22 +0000 (GMT)
Date:   Thu, 24 Feb 2022 12:36:20 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] KVM: s390: Don't cast parameter in bit
 operations
Message-ID: <20220224123620.57fd6c8b@p-imbrenda>
In-Reply-To: <20220223164420.45344-1-andriy.shevchenko@linux.intel.com>
References: <20220223164420.45344-1-andriy.shevchenko@linux.intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KMYavoUxHNIVE3KTDhbCQfvUYOvE7o2Q
X-Proofpoint-ORIG-GUID: 1-JncAn_mRQ-bcwR4-n6DEWr-MLIJuut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_02,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202240068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 23 Feb 2022 18:44:20 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case somebody blindly
> copies to their code.
> 
> Don't cast parameter to unsigned long pointer in the bit operations.
> Instead copy to a local variable on stack of a proper type and use.
> 
> Fixes: d77e64141e32 ("KVM: s390: implement GISA IPM related primitives")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 5 ++++-
>  arch/s390/kvm/interrupt.c        | 6 +++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index a22c9266ea05..f1c4a1b9b360 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -867,7 +867,10 @@ struct kvm_s390_gisa {
>  			u8  reserved03[11];
>  			u32 airq_count;
>  		} g1;
> -		struct {
> +		struct { /* as a 256-bit bitmap */
> +			DECLARE_BITMAP(b, 256);
> +		} bitmap;
> +		struct { /* as a set of 64-bit words */
>  			u64 word[4];
>  		} u64;
>  	};
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index db933c252dbc..04e055cbd080 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -304,7 +304,7 @@ static inline int gisa_in_alert_list(struct kvm_s390_gisa *gisa)
>  
>  static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
> -	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +	set_bit_inv(IPM_BIT_OFFSET + gisc, gisa->bitmap.b);

wouldn't it be enough to pass gisa->u64.word here?
then no cast would be necessary

>  }
>  
>  static inline u8 gisa_get_ipm(struct kvm_s390_gisa *gisa)
> @@ -314,12 +314,12 @@ static inline u8 gisa_get_ipm(struct kvm_s390_gisa *gisa)
>  
>  static inline void gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
> -	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +	clear_bit_inv(IPM_BIT_OFFSET + gisc, gisa->bitmap.b);
>  }
>  
>  static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
> -	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> +	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, gisa->bitmap.b);
>  }
>  
>  static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)

