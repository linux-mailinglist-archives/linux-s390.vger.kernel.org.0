Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D784AC22E
	for <lists+linux-s390@lfdr.de>; Mon,  7 Feb 2022 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiBGO6B (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Feb 2022 09:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiBGOh4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Feb 2022 09:37:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB8C0401C1;
        Mon,  7 Feb 2022 06:37:56 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217DFGI9005118;
        Mon, 7 Feb 2022 14:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cTR9ZXIYcP+4BYSAj0LxosDzLtcKa4Wv2bJf1hsmYdU=;
 b=G/R7uvcT4B/yw95xBJEruVikznP0SeGfPdptMNbo0KP+e+BlNe8uuYaY9gq+Li23t7Xb
 JUrdHu68jm1Vlnh3kb4vby4wD/0aRGNqGywdPwsZLA3bwC0vBEdQ0mYQ3Q6bNiRwaokt
 mhy/JMMfCqK45ga1RzjgM/GpBLCfVLcAR04OLr+tXsWds6qOnC3zgbESdHzFgnpenx+O
 Oro1xogYLDzcv/irINP6NdJbeMC/cXHL9eUrnaZ4AVzF5C08bik5CpeFJxmIXMG1ZojB
 MHi9UwlugfJYSksk4LzxeLduw13YqtzxQ1MCXcHa9n2x4ayxXV2JmJ17Elu276pXNGtS yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22m5x8af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 14:37:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217EHa5H025807;
        Mon, 7 Feb 2022 14:37:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22m5x89q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 14:37:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217EW1kL025588;
        Mon, 7 Feb 2022 14:37:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggjnsfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 14:37:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217Ebn2h44499304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 14:37:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D03942041;
        Mon,  7 Feb 2022 14:37:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E257D4203F;
        Mon,  7 Feb 2022 14:37:48 +0000 (GMT)
Received: from [9.145.9.42] (unknown [9.145.9.42])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 14:37:48 +0000 (GMT)
Message-ID: <2b9b31bf-e45a-7006-c68e-6e143665640c@linux.ibm.com>
Date:   Mon, 7 Feb 2022 15:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 16/17] KVM: s390: pv: add
 KVM_CAP_S390_PROT_REBOOT_ASYNC
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
        david@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, scgl@linux.ibm.com
References: <20220204155349.63238-1-imbrenda@linux.ibm.com>
 <20220204155349.63238-17-imbrenda@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220204155349.63238-17-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AFt_8BGPlWKQ9vvRNpS2Ntgp1qpVLHtw
X-Proofpoint-ORIG-GUID: jYXNpELGffd-tgqJv4YlgJiV-7N31ydl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/4/22 16:53, Claudio Imbrenda wrote:
> Add KVM_CAP_S390_PROT_REBOOT_ASYNC to signal that the
> KVM_PV_ASYNC_DISABLE and KVM_PV_ASYNC_DISABLE_PREPARE commands for the
> KVM_S390_PV_COMMAND ioctl are available.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 3 +++
>   include/uapi/linux/kvm.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f7952cef1309..1e696202a569 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -608,6 +608,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_BPB:
>   		r = test_facility(82);
>   		break;
> +	case KVM_CAP_S390_PROT_REBOOT_ASYNC:
> +		r = lazy_destroy && is_prot_virt_host();

While reboot might be the best use-case for the async disable I don't 
think we should name the capability this way.

KVM_CAP_S390_PROTECTED_ASYNC_DESTR ?

It's a bit long but the initial capability didn't abbreviate the 
protected part so it is what it is.


> +		break;
>   	case KVM_CAP_S390_PROTECTED:
>   		r = is_prot_virt_host();
>   		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 7f574c87a6ba..c41c108f6b14 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1134,6 +1134,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_VM_GPA_BITS 207
>   #define KVM_CAP_XSAVE2 208
>   #define KVM_CAP_SYS_ATTRIBUTES 209
> +#define KVM_CAP_S390_PROT_REBOOT_ASYNC 215
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> 

