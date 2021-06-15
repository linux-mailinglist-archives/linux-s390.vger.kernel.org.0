Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3013A799A
	for <lists+linux-s390@lfdr.de>; Tue, 15 Jun 2021 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFOI53 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Jun 2021 04:57:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhFOI52 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 04:57:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15F8nCWN030107;
        Tue, 15 Jun 2021 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jHhXVE6/BfhtWohjfHpGzy30Rkxsc0DMNA++WMrN6D0=;
 b=jo+N2oMa5m2vAnZd2lF5T2rY2sDWMZohFBxKHpXITdLV6j0R6gXUz93P5pDrJMXThcph
 cXtV65z/kTqKwPT3Pw3OtW5pl4TtAtByrGFEeSAQjQV0mA49xlqVU5F5fdWwjJCI7c+9
 IYV1iD7YzWr5xJxR9HlVHcn50Mmsqrdp9uH4THa/beYtbb7wiMoepVdbN+sjxcX2DXEa
 FBm+iJnumKKWKa4MdQnyJIO9EwGE79zh0BoMG4lQMjoDtQXfSEFMFr1LS7px9vdzsx7g
 gbtEfFW0mpcyf/Wac9Dr3qfmcL/suDL3H8IR1OlpEW76AjLkQttgY6G8toQ7AjljC7mD WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396s1hg3ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 04:55:20 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15F8pIvP043089;
        Tue, 15 Jun 2021 04:55:19 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396s1hg3fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 04:55:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15F8rCeT024380;
        Tue, 15 Jun 2021 08:55:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hscbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 08:55:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15F8tDc212386812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 08:55:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1F652059;
        Tue, 15 Jun 2021 08:55:13 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.85.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F0C2852052;
        Tue, 15 Jun 2021 08:55:12 +0000 (GMT)
Subject: Re: [PATCH 3/3] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-4-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <feff8d63-c2e0-73a3-83ae-a6a5e549194a@de.ibm.com>
Date:   Tue, 15 Jun 2021 10:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210609224634.575156-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hCG9fKVZ65E2cOJfmS09OYnKEqLytMjA
X-Proofpoint-GUID: SmhyFqlu7n1lJQoQF2QQUzkfKqQ8Nct_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_04:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150051
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.06.21 00:46, Tony Krowiak wrote:
> The function pointer to the interception handler for the PQAP instruction
> can get changed during the interception process. Let's add a
> semaphore to struct kvm_s390_crypto to control read/write access to the
> function pointer contained therein.
> 
> The semaphore must be locked for write access by the vfio_ap device driver
> when notified that the KVM pointer has been set or cleared. It must be
> locked for read access by the interception framework when the PQAP
> instruction is intercepted.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Given that patch 2 is still  under discussion. Can this patch go without patch 2?
> ---
>   arch/s390/include/asm/kvm_host.h      |  6 +++---
>   arch/s390/kvm/kvm-s390.c              |  1 +
>   arch/s390/kvm/priv.c                  |  6 +++---
>   drivers/s390/crypto/vfio_ap_ops.c     | 14 ++++++++++----
>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>   5 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..58edaa3f9602 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -803,14 +803,14 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> -struct kvm_s390_module_hook {
> +struct kvm_s390_crypto_hook {
>   	int (*hook)(struct kvm_vcpu *vcpu);
> -	struct module *owner;
>   };
>   
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> -	struct kvm_s390_module_hook *pqap_hook;
> +	struct rw_semaphore pqap_hook_rwsem;
> +	struct kvm_s390_crypto_hook *pqap_hook;
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1296fc10f80c..418d910df569 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2606,6 +2606,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>   {
>   	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>   	kvm_s390_set_crycb_format(kvm);
> +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>   
>   	if (!test_kvm_facility(kvm, 76))
>   		return;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..bbbd84ffe239 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -657,15 +657,15 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * Verify that the hook callback is registered, lock the owner
>   	 * and call the hook.
>   	 */
> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
>   		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>   		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>   			kvm_s390_set_psw_cc(vcpu, 3);
> +		up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   		return ret;
>   	}
> +	up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	/*
>   	 * A vfio_driver must register a hook.
>   	 * No hook means no driver to enable the SIE CRYCB and no queues.
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index d65a5728153b..2998c1b53ab9 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -342,7 +342,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   	init_rwsem(&matrix_mdev->rwsem);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
>   
>   	mutex_lock(&matrix_dev->lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> @@ -1063,7 +1062,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   	down_write(&matrix_mdev->rwsem);
>   	matrix_mdev->kvm = kvm;
>   	kvm_get_kvm(kvm);
> -	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>   	up_write(&matrix_mdev->rwsem);
>   
>   	/*
> @@ -1071,6 +1069,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   	 * masks for the KVM guest
>   	 */
>   	if (kvm->arch.crypto.crycbd) {
> +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +
>   		down_read(&matrix_mdev->matrix.rwsem);
>   		kvm_arch_crypto_set_masks(kvm,
>   					  matrix_mdev->matrix.apm,
> @@ -1122,11 +1124,15 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   {
>   	if (matrix_mdev->kvm) {
> -		if (matrix_mdev->kvm->arch.crypto.crycbd)
> +		if (matrix_mdev->kvm->arch.crypto.crycbd) {
> +			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +
>   			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> +		}
>   
>   		down_write(&matrix_mdev->rwsem);
> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>   		kvm_put_kvm(matrix_mdev->kvm);
>   		matrix_mdev->kvm = NULL;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index a163ac04ff8a..3d6afd0faaaf 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -90,7 +90,7 @@ struct ap_matrix_mdev {
>   	struct notifier_block iommu_notifier;
>   	struct rw_semaphore rwsem;
>   	struct kvm *kvm;
> -	struct kvm_s390_module_hook pqap_hook;
> +	struct kvm_s390_crypto_hook pqap_hook;
>   	struct mdev_device *mdev;
>   };
>   
> 
