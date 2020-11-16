Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC92B4F0A
	for <lists+linux-s390@lfdr.de>; Mon, 16 Nov 2020 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgKPSS0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Nov 2020 13:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730105AbgKPSS0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 13:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605550704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAHP+8zyc4EwCkB9PCeaZBFISgE3jVYS9b2gGcqczD8=;
        b=My77GVUHFXsZR17ZIBPTlApCvzoRTcGLmhMHhIsUXWt+bHkMjrQUjbSmNPBQ7tXCKXgRbo
        sV54Qv4rC/rRWNPvGjqOQAkTQ3bpJGlUpCQLz3KnrC3u2/ghjWaPHh4w74VHXz1spWcu4r
        F2X64BYOqebSjxXB3f/MlZ3XPO9/278=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-WOKL3IiiMWWxRAtiHbjPEQ-1; Mon, 16 Nov 2020 13:18:23 -0500
X-MC-Unique: WOKL3IiiMWWxRAtiHbjPEQ-1
Received: by mail-wm1-f71.google.com with SMTP id g3so55654wmh.9
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2020 10:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tAHP+8zyc4EwCkB9PCeaZBFISgE3jVYS9b2gGcqczD8=;
        b=e+EEaZl8nlhqWQLttbVIPrBqpZAmWTER/vk2JnkoGuFfzl3QNZ8EcrW2pzOU1uQisT
         6kp6fpUAH4YKzwc60gN6o4ZNAPpoV4Q10G/HF1GG+CDCl/1ksOgJYmD2eYcMil3outmt
         Cf9WjAXUDXgMJ5UYcmn6YXbk5W4dFFAmzpsKqXAJeqL5hAN5xdlNeqUgNP1WuEsbz6OM
         HOZ4f3/zsUeAAxGuqzjPUmrnpI6G+XGa8SqvOnGgcuZNVAf+LhhzKm6xl45aOOhI73d5
         zbZUe+zKgsmLWH38bzwAhXr06K7BogY5NEWSWR8F+AxCV6AZFp3ktdZhkezyfsRd1KIb
         Z0ag==
X-Gm-Message-State: AOAM530M9cSFRGiptlCjvNHRsynpXkTv2pvb2ffnGXTabqA9AXspfeGZ
        B3OtiTaDiiG/yX5isS6VX64MaTD0feZF13fcwC6svwBPVOSc0ytDRORaMh4vsAoXAAa7fYQMdPY
        caiPj9iZ5gx8HNRVBIuAu0g==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr150567wme.85.1605550702211;
        Mon, 16 Nov 2020 10:18:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO+z7hGfmJQS3UwtqvJGNRuNGNPfzM4u6SHMsc6XraQ5bpbjaI7svja2TpFhiq14tNRZ02Sg==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr150549wme.85.1605550702047;
        Mon, 16 Nov 2020 10:18:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s25sm144541wmh.16.2020.11.16.10.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 10:18:21 -0800 (PST)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 5.10
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Collin Walling <walling@linux.ibm.com>
References: <20201116122033.382372-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2ce11de-e2b4-206e-f6d5-0f21da73cd5a@redhat.com>
Date:   Mon, 16 Nov 2020 19:18:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116122033.382372-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/11/20 13:20, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.10-1

Pulled, thanks.

Paolo

