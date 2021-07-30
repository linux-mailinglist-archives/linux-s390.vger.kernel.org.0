Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA533DBB6B
	for <lists+linux-s390@lfdr.de>; Fri, 30 Jul 2021 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhG3OyU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 30 Jul 2021 10:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239370AbhG3OyT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627656854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP9UshPvbz8YoLOzWnPB+DZvElzHipfy18IZoTE1sak=;
        b=RvAKA3pG65uQRioUXTUJhPgVgjQuJyzVBV5PlJxV3qBgopcGiQK1RBr3G0lANDu+8cBHRF
        myZRnWSt16MuFUKf7U4QLVPOT17Ipim4zotYm9be9qygh2AUuuqcaxO1U2VDpcYdS5zoBc
        HkgUF5vOej+yHacRlLqZcDR37yhBF6A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-9awi2ValNKe4AXbNKZvhlA-1; Fri, 30 Jul 2021 10:54:13 -0400
X-MC-Unique: 9awi2ValNKe4AXbNKZvhlA-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020adfda510000b02901526f76d738so3309700wrl.0
        for <linux-s390@vger.kernel.org>; Fri, 30 Jul 2021 07:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vP9UshPvbz8YoLOzWnPB+DZvElzHipfy18IZoTE1sak=;
        b=plT4K0aDUmfEhlSaSoZX413cd4o6j3o5DUnjC+HBhaeAMfgW25nLVvd1CIon1tBjbQ
         MZgMyy2xoyLi+QPcthmAYE+edAwtNQcfx4s0IOylgMp6whHQBtT9cwHWqmc+XnMBO9XZ
         rpctthhpHchVYf3JC9YbyUfcTQRQQtJNRnQRDJsOtP3RPLFiecUgR5yi2niJPVmta/tN
         IsP5nA5k1EqNH7nn1TgWKXcDmwW8wh5pVnJYTFLTy4F5xmwhMwDIPRg6xYV4C6apvYAZ
         pbZqck5i2xDIH2AW8eQdRhi9nq1J7qWHdbOKzP7nqT3g63RjaAxVx7SH5CJO+hjWlEv3
         IfUQ==
X-Gm-Message-State: AOAM53134jnE2wUDlOTIeYsQ9E7CGxn+E18A5FJgwloLq50828fk5OsC
        7ijcJc9cT3OuydXglvX2GAlcsZVh/HuLe6s0NPfJAVqr9tvKfiDhNL/NutVfyV/5WdaSIZIz5M/
        J6qLyDSVe5k5M42vpOqk0cA==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr3365326wmo.27.1627656852148;
        Fri, 30 Jul 2021 07:54:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnhYLRVeborZsaIV3naK2XsDF7jWBJ/fPAzAWtBaZX12E6P4p3lC1/JDHRJsKDlmjzoAiQKg==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr3365312wmo.27.1627656852014;
        Fri, 30 Jul 2021 07:54:12 -0700 (PDT)
Received: from thuth.remote.csb (p5791d280.dip0.t-ipconnect.de. [87.145.210.128])
        by smtp.gmail.com with ESMTPSA id d15sm2105209wri.39.2021.07.30.07.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 07:54:11 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 4/4] lib: s390x: sie: Move sie function
 into library
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210729134803.183358-1-frankja@linux.ibm.com>
 <20210729134803.183358-5-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <d6f15c93-3b9a-6a95-4d6b-db8d9c513bd2@redhat.com>
Date:   Fri, 30 Jul 2021 16:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729134803.183358-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/07/2021 15.48, Janosch Frank wrote:
> Time to deduplicate more code.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/sie.c  | 13 +++++++++++++
>   lib/s390x/sie.h  |  1 +
>   s390x/mvpg-sie.c | 13 -------------
>   s390x/sie.c      | 17 -----------------
>   4 files changed, 14 insertions(+), 30 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

