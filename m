Return-Path: <linux-s390+bounces-7092-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA59CDBA0
	for <lists+linux-s390@lfdr.de>; Fri, 15 Nov 2024 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6BCB24B58
	for <lists+linux-s390@lfdr.de>; Fri, 15 Nov 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213219004E;
	Fri, 15 Nov 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPugMWDN"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F32C80
	for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663146; cv=none; b=kEwx5pxbWxooBSkyTwniNM6DLmmauzCTH7VL7tqVHattH9DmMK0IvFvRHal2fhDAQqcOaPv87Xue2INmhl/ywRgSP/kcotwwdDXjGvQpsm7I3E1SAGX5HpB/1xlBULGSENy1edEoQJDcvWcJNVZBkF56982JIZ4pwLrw575TpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663146; c=relaxed/simple;
	bh=vUexfnWVk9f6k/KMkU1aFdPAfCAr1o36Pyvfqbyu3cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJv+EADc8jgKoSotIPEoF8zgYLrj13XEJyyTOyhuGBHnGATJeFkmIiZuUzMWwzGtVvyLndITFV9unxq8iBw8aFwOUtpCb/i4dry5AYh1sd2H8hQ0Ty+DfAh301GKNXdAYzwjUoV8Ii9EzgXD83aLFtOBQvPfjavc+fHykVJJ/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPugMWDN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731663143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTb9CW/O4FNO2bJEfjkk0JvxsXhX0aFHQ7YtvawnJ8k=;
	b=OPugMWDNT7CKdzEKL16ApwDJGRG3Jrpwun3fnQbARyjQEWzJDiCr0nt7kBYFif6xBCGfFT
	E+91Tt4810lXIz484uLdc0kAkM0Ho+nATYUoP6AHEqbEl0dZxxwIiHrzWB6eS2AvDqGpsP
	T6PJfIa5u5YoW0UYcP5hzywU4e+fFEQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-rR9C9h7POICGfn4aApvOXA-1; Fri,
 15 Nov 2024 04:32:19 -0500
X-MC-Unique: rR9C9h7POICGfn4aApvOXA-1
X-Mimecast-MFC-AGG-ID: rR9C9h7POICGfn4aApvOXA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E0E195395F;
	Fri, 15 Nov 2024 09:32:16 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722501955F43;
	Fri, 15 Nov 2024 09:32:14 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:32:10 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 02/11] fs/proc/vmcore: replace vmcoredd_mutex by
 vmcore_mutex
Message-ID: <ZzcVGrUcgNMXPkqw@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-3-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> Let's use our new mutex instead.

Is there reason vmcoredd_mutex need be replaced and integrated with the
vmcore_mutex? Is it the reason the concurrent opening of vmcore could
happen with the old vmcoredd_mutex?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 110ce193d20f..b91c304463c9 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
> -static DEFINE_MUTEX(vmcoredd_mutex);
>  
>  static bool vmcoredd_disabled;
>  core_param(novmcoredd, vmcoredd_disabled, bool, 0);
> @@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
>  	size_t tsz;
>  	char *buf;
>  
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_for_each_entry(dump, &vmcoredd_list, list) {
>  		if (start < offset + dump->size) {
>  			tsz = min(offset + (u64)dump->size - start, (u64)size);
> @@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  	return ret;
>  }
>  
> @@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
>  	size_t tsz;
>  	char *buf;
>  
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_for_each_entry(dump, &vmcoredd_list, list) {
>  		if (start < offset + dump->size) {
>  			tsz = min(offset + (u64)dump->size - start, (u64)size);
> @@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  	return ret;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1517,9 +1516,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->size = data_size;
>  
>  	/* Add the dump to driver sysfs list */
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_add_tail(&dump->list, &vmcoredd_list);
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	vmcoredd_update_size(data_size);
>  	return 0;
> @@ -1537,7 +1536,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
>  static void vmcore_free_device_dumps(void)
>  {
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	while (!list_empty(&vmcoredd_list)) {
>  		struct vmcoredd_node *dump;
>  
> @@ -1547,7 +1546,7 @@ static void vmcore_free_device_dumps(void)
>  		vfree(dump->buf);
>  		vfree(dump);
>  	}
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  }
>  
> -- 
> 2.46.1
> 


